import Foundation

struct URLConstants
{
    static let urlDomain = "http://localhost:3000"
    
    static let urlUsers = "\(URLConstants.urlDomain)/users"
    static let urlAlbums = "\(URLConstants.urlDomain)/albums?userId="
    static let urlPosts = "\(URLConstants.urlDomain)/posts?userId="
    static let urlComments = "\(URLConstants.urlDomain)/posts"
    static let urlUplComment = "\(URLConstants.urlDomain)/comments?postId="
    static let urlDelComment = "\(URLConstants.urlDomain)/comments/"
    
    static let urlBigImage = "https://images.wallpaperscraft.ru/image/lodka_voda_vid_sverhu_197654_2645x2160.jpg"
}
