//
//  APIServices.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation

protocol APIService {
    
//MARK: - product Info
    
    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void ) )

    
//MARK: -       register new customer
    
    func registerCustomer(newCustomer: NewCustomer, completion: @escaping ((NewCustomer?, Error?) -> Void))
    
//MARK: -                           Login
    
    func retriveCustomers(completion: @escaping (([Customer]?, Error?) -> Void))
    
    
}

//MARK: - Brands
protocol BrandsAPIService {
    
    func fetchBrands(completion: @escaping (([BrandsModel]?, Error?) -> Void ) )
    
}

//MARK: - products
protocol ProductsAPIService {
    
    func fetchProducts(completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}
