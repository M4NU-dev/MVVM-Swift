//
//  MainView.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/30/21.
//

import UIKit
import RxSwift
import Network

class MainView: UIViewController {
    @IBOutlet weak var tbListArticles: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private var router      = MainRouter()
    private var viewModel   = MainViewModel()
    private var disposeBag  = DisposeBag()
    private var objectHits  = ObjectHits()    
    private let refreshData = UIRefreshControl()
    private var isInternet  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        
        settingsTable()
        viewModel.bind(view: self, rooter: router)
        
        if isInternet {
            getData()
        } else {
            getDataTemp()
        }
    }
    
    private func settingsTable() {
        if #available(iOS 10.0, *) {
            tbListArticles.refreshControl = refreshData
        } else {
            tbListArticles.addSubview(refreshData)
        }
        
        refreshData.tintColor       = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshData.attributedTitle = NSAttributedString(string: "Actualizando datos...")
        tbListArticles.rowHeight    = UITableView.automaticDimension
        
        refreshData.addTarget(self, action: #selector(refresArticlesData(_:)), for: .valueChanged)
        tbListArticles.register(UINib(nibName: "ItemArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemArticleTableViewCell")
    }
    
    private func getData() {
        return viewModel.getListArticles()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { ObjectHits in
                self.objectHits = ObjectHits
                self.loadDataTable()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                
            }
            .disposed(by: disposeBag)

    }
    
    private func getDataTemp() {
        self.viewModel.mData.getData(key: Constants.STRING_KEYS.TEMP_DATA, value_default: "") { (json) in
            do {
                let jsonDecoder = JSONDecoder()
                self.objectHits = try jsonDecoder.decode(ObjectHits.self, from: json.data(using: .utf8)!)
                
                self.processDataDelete()
                self.componentsUI()
                
            } catch {
                print("JSONSerialization error:", error)
            }
        }
    }
    
    private func loadDataTable() {
        DispatchQueue.main.async {
            
            // ESTE PROCESO NO ES RECOMENDADO REALIZAR POR NINGUN MOTIVO
            // LO LOGICO ES QUE EXISTA UN SERVICIO QUE PERMITA ELIMINAR ARTICULOS DEL SERVIDOR Y
            // NO TENER QUE REALIZAR ESTE PROCESO DE ESTA FORMA
            if self.objectHits.articulos!.count > 0 {
                self.processDataDelete()
            }
            
            self.componentsUI()
        }
    }
    
    private func processDataDelete() {
        self.viewModel.mData.getData(key: Constants.STRING_KEYS.DELETE_DATA, value_default: "") { (json) in
            do {
                
                if json == "" {
                    self.setDataLocal(objectHits: self.objectHits)
                }else {
                    let jsonDecoder    = JSONDecoder()
                    var deleteArticles = try jsonDecoder.decode(ObjectHits.self, from: json.data(using: .utf8)!)
                    
                    for i in (0..<self.objectHits.articulos!.count).reversed() {
                        for j in 0..<deleteArticles.articulos!.count {
                            if self.objectHits.articulos![i].storyId == deleteArticles.articulos![j].storyId {
                                self.objectHits.articulos?.remove(at: i)
                            }
                        }                        
                    }
                }
                
            } catch {
                print("JSONSerialization error:", error)
            }
        }
    }
    
    private func setDataLocal(objectHits: ObjectHits) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(objectHits)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
                          
            self.viewModel.mData.setData(data: json, key: Constants.STRING_KEYS.TEMP_DATA)
        } catch {
            print("JSONSerialization error:", error)
        }
    }
    
    private func componentsUI() {
        self.loading.stopAnimating()
        self.refreshData.endRefreshing()
        self.loading.isHidden = true
        self.tbListArticles.reloadData()
    }
    
    @objc private func refresArticlesData(_ sender: Any) {
        if isInternet {
            getData()
        } else {
            getDataTemp()
        }
    }
    
    private func monitorNetwork() {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isInternet = true
            }else{
                self.isInternet = false
            }
        }
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "ELIMINAR") { (action, indexPath) in
            self.viewModel.deleteArticle(article: self.objectHits.articulos![indexPath.row])
            self.objectHits.articulos?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectHits.articulos!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemArticleTableViewCell.self)) as! ItemArticleTableViewCell
        
        cell.txt_title.text = self.objectHits.articulos![indexPath.row].HighlightResult?.storyTitle?.value
        cell.txt_time.text  = "\((self.objectHits.articulos![indexPath.row].HighlightResult?.author?.value)!) - \(self.objectHits.articulos![indexPath.row].getPublishedDate())"
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.makeDetailArticle(url: self.objectHits.articulos![indexPath.row].storyUrl!)
    }
}
