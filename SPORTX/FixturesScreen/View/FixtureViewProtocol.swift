//
//  FixtureViewProtocol.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

protocol FixtureViewProtocol {
    func updateData(teamOrPlayer: [TeamOrPlayer])
    func updateData(upcomingFixture: [Fixture], latestFixture: [Fixture])
}
