//
//  LeftMenuSectionsUtils.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit


public enum CellIdentifier {
    case CategoriesCellIdentifier
    case SignUserCellIdentifier
    case SubscriptionsCellIdentifier
}

public struct MenuRowItemInfo {
    var title :       String
    var imageUrl :    String
    var rowHParas :   Int
}

public struct MenuSectionItemInfo {
    var sectionIdentifier :    CellIdentifier
    var sectionType :          MenuSectionType
    var headerTitle :          String
    var rows :                 [MenuRowItemInfo]
    var isHideTitle :          Bool
    var isRemoteImage :        Bool
}

public enum MenuSectionType {
    case LMenuTreeCategories
    case LMenuTreeUser
    case LMenuTreeSubscriptions
}




public class LeftMenuSectionsUtils {
    
    
    func getDefaultCategories() ->[MenuRowItemInfo]{
        return [
            MenuRowItemInfo(title: "Autos & Vehicles",        imageUrl: "Autos",           rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Comedy",                  imageUrl: "Comedy",          rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Education",               imageUrl: "Education",       rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Entertainment",           imageUrl: "Entertainment",   rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "File & Animation",        imageUrl: "Film",            rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Gaming",                  imageUrl: "Games",           rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Howto & Style",           imageUrl: "Howto",           rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Music",                   imageUrl: "Music",           rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "News & Politics",         imageUrl: "News",            rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Nonprofits & Activism",   imageUrl: "Nonprofit",       rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "People & Blogs",          imageUrl: "People",          rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Pets & Animals",          imageUrl: "Animals",         rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Science & Technology",    imageUrl: "Tech",            rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Sports",                  imageUrl: "Sports",          rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
            MenuRowItemInfo(title: "Travel & Events",         imageUrl: "Travel",          rowHParas: YTPlayListItemsType.kUploadsTag.rawValue     ),
        ]
    }
    
    func getSignUserCategoriess() ->[MenuRowItemInfo]{
        return [
            MenuRowItemInfo(title: "Subscriptions",    imageUrl: "subscriptions",   rowHParas: YTPlayListItemsType.kUploadsTag.rawValue           ),
            MenuRowItemInfo(title: "What to Watch",    imageUrl: "recommended",     rowHParas: YTPlayListItemsType.kWatchHistoryTag.rawValue      ),
            MenuRowItemInfo(title: "Favorite",         imageUrl: "favorites",       rowHParas: YTPlayListItemsType.kFavoritesTag.rawValue         ),
            MenuRowItemInfo(title: "Watch Later",      imageUrl: "watch_later",     rowHParas: YTPlayListItemsType.kWatchLaterTag.rawValue        ),
            MenuRowItemInfo(title: "Playlists",        imageUrl: "playlists",       rowHParas: YTPlayListItemsType.kUploadsTag.rawValue           ),
        ]
    }
    
    func getCategoriesMenuItemTree() -> MenuSectionItemInfo{
        return
            MenuSectionItemInfo(
                sectionIdentifier:    CellIdentifier.CategoriesCellIdentifier,
                sectionType:          MenuSectionType.LMenuTreeCategories,
                headerTitle:          "Categories",
                rows:                 getDefaultCategories(),
                isHideTitle:          false,
                isRemoteImage:        false
        )
    }
    
    
    func getSignInMenuItemTree() -> MenuSectionItemInfo{
        return
            MenuSectionItemInfo(
                sectionIdentifier:    CellIdentifier.SignUserCellIdentifier,
                sectionType:          MenuSectionType.LMenuTreeUser,
                headerTitle:          "",
                rows:                 getSignUserCategoriess(),
                isHideTitle:          true,
                isRemoteImage:        false
        )
    }
    
    
    func getEmptySubscriptionsMenuItemTree() -> MenuSectionItemInfo{
        return
            MenuSectionItemInfo(
                sectionIdentifier:    CellIdentifier.SubscriptionsCellIdentifier,
                sectionType:          MenuSectionType.LMenuTreeSubscriptions,
                headerTitle:          "  Subscriptions",
                rows:                 [],
                isHideTitle:          false,
                isRemoteImage:        true
        )
    }
    
    func getSignOutMenuItemTreeArray() -> [MenuSectionItemInfo]{
        return [
            getCategoriesMenuItemTree()
        ]
    }
    
    func getSignInMenuItemTreeArray() -> [MenuSectionItemInfo]{
        return [
            getSignInMenuItemTree(),
            getEmptySubscriptionsMenuItemTree(),
            getCategoriesMenuItemTree()
        ]
    }
    
}
