//
//  LoginRepository.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation

public class LoginRepository: BaseRepository<LoginResponseEntity> {
    public override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    public func login() async throws -> DataEntity<LoginResponseEntity> {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return DataEntity(data: LoginResponseEntity(status: true,
                                                    accessToken: "ACCESS_TOKEN",
                                                    refreshToken: "REFRESH_TOKEN"),
                          message: nil) 
    }
}
