//
//  PostViewController.swift
//  Instagram
//
//  Created by Peter Emil on 09/07/2022.
//

import UIKit
import CoreMedia

/// States of rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // Post
    case actions(provider: String) //like, comment, share
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private var model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        
        // Register Cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)

        return tableView
    }()
    
    //MARK: - Init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        

        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
 
    private func configureModels() {
        guard let userPostModel = self.model else { return }
        
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@dave", text: "Great Post", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }

}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            
        case .header(provider: _):
            return 1
        case .primaryContent(provider: _):
            return 1
        case .actions(provider: _):
            return 1
        case .comments(comments: let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            
        case .header(provider: let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
            
        case .primaryContent(provider: let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .actions(provider: let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(comments: let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            
        case .header(_): return 70
            
        case .primaryContent(_): return tableView.width
            
        case .actions(_): return 60
            
        case .comments(_): return 50
            
        }
    }
}
