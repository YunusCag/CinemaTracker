//
//  DetailTopView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 19.07.2023.
//

import UIKit
import SnapKit


class DetailTopView: UIView {
    
    private lazy var smallImageView: MovieImageView = {
       let movieImage = MovieImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 150))
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 5
        movieImage.contentMode = .scaleAspectFill
        return movieImage
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var labelCountry = AppLabel()
    private lazy var labelGenre = AppLabel()
    private lazy var labelBudget = AppLabel()
    private lazy var labelRevenue = AppLabel()
    private lazy var labelDate = AppLabel()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    
    private func createView() {
        addSubview(smallImageView)
        addSubview(stackView)
        
        smallImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(smallImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
        }
        
        
        
        
        labelCountry.initStyle(typograph: .small1,color: AppTheme.shared.colors.textPrimary)
        labelCountry.numberOfLines = 3
        labelCountry.lineBreakMode = .byTruncatingTail
        
        labelGenre.initStyle(typograph: .small1,color: AppTheme.shared.colors.textPrimary)
        labelGenre.numberOfLines = 3
        labelGenre.lineBreakMode = .byTruncatingTail
        
        labelBudget.initStyle(typograph: .small1,color: AppTheme.shared.colors.textPrimary)
        labelBudget.numberOfLines = 1
        labelBudget.lineBreakMode = .byTruncatingTail
        
        labelRevenue.initStyle(typograph: .small1,color: AppTheme.shared.colors.textPrimary)
        labelRevenue.numberOfLines = 1
        labelRevenue.lineBreakMode = .byTruncatingTail
        
        labelDate.initStyle(typograph: .small1,color: AppTheme.shared.colors.textPrimary)
        labelDate.numberOfLines = 1
        labelDate.lineBreakMode = .byTruncatingTail
    }
    
    
    func saveDetail(detail:MovieDetailResponse) {
        smallImageView.saveUrl(path: detail.posterPath)
        
        if let countries = detail.productionCountries {
            if !countries.isEmpty {
                stackView.addArrangedSubview(labelCountry)
                saveCountries(countries)
            }
        }
        if let genres = detail.genres {
            if !genres.isEmpty {
                stackView.addArrangedSubview(labelGenre)
                saveGenres(genres)
            }
        }
        if let budget = detail.budget {
            stackView.addArrangedSubview(labelBudget)
            saveBudget(budget: budget)
        }
        if let revenue = detail.revenue {
            stackView.addArrangedSubview(labelRevenue)
            saveRevenue(revenue: revenue)
        }
        if let releaseDate = detail.releaseDate {
            stackView.addArrangedSubview(labelDate)
            saveRelease(date: releaseDate)
        }
    }
    
    fileprivate func saveCountries(_ countries: [ProductionCountryModel]) {
        
        let firstLine = "\(LocalizableKeys.MovieDetail.country.getLocalized())\t"
        var countryText = firstLine
        
        for (index,country) in countries.enumerated() {
            var name = country.name ?? Constant.StringParameter.EMPTY_STRING
            if index != countries.count - 1 {
                name.append(Constant.StringParameter.VERTICAL_BAR)
            }
            countryText.append(name)
        }
        
        let attributedText = NSMutableAttributedString(string: countryText)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppTheme.shared.colors.secondary,.font: UIFont.boldSystemFont(ofSize: 12 )]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: firstLine.count))
        
        labelCountry.attributedText = attributedText
    }
    
    fileprivate func saveGenres(_ genres: [GenreModel]) {
        let firstLine = "\(LocalizableKeys.MovieDetail.genre.getLocalized())\t"
        var genreText = firstLine
        
        for (index,genre) in genres.enumerated() {
            var name = genre.name ?? Constant.StringParameter.EMPTY_STRING
            if index != genres.count - 1 {
                name.append(Constant.StringParameter.VERTICAL_BAR)
            }
            genreText.append(name)
        }
        
        let attributedText = NSMutableAttributedString(string: genreText)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppTheme.shared.colors.secondary,.font: UIFont.boldSystemFont(ofSize: 12 )]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: firstLine.count))
        
        labelGenre.attributedText = attributedText
    }
    
    fileprivate func saveBudget(budget: Int) {
        if budget == 0 {
            return
        }
        
        let firstLine = "\(LocalizableKeys.MovieDetail.budget.getLocalized())\t"
        let budgetNumber =  NSNumber(value:budget)
        let budgetString = numberFormatter.string(from: budgetNumber)
        
        var budgetText = firstLine
        budgetText.append(budgetString ?? Constant.StringParameter.EMPTY_STRING)
        budgetText.append(Constant.StringParameter.SPACE_STRING)
        budgetText.append(LocalizableKeys.MovieDetail.currency.getLocalized())
        
        let attributedText = NSMutableAttributedString(string: budgetText)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppTheme.shared.colors.secondary,.font: UIFont.boldSystemFont(ofSize: 12 )]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: firstLine.count))
        
        labelBudget.attributedText = attributedText
    }
    
    fileprivate func saveRevenue(revenue: Int) {
        if revenue == 0 {
            return
        }
        
        let firstLine = "\(LocalizableKeys.MovieDetail.revenue.getLocalized())\t"
        let revenueNumber =  NSNumber(value:revenue)
        let revenueString = numberFormatter.string(from: revenueNumber)
        
        var revenueText = firstLine
        revenueText.append(revenueString ?? Constant.StringParameter.EMPTY_STRING)
        revenueText.append(Constant.StringParameter.SPACE_STRING)
        revenueText.append(LocalizableKeys.MovieDetail.currency.getLocalized())
        
        let attributedText = NSMutableAttributedString(string: revenueText)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppTheme.shared.colors.secondary,.font: UIFont.boldSystemFont(ofSize: 12 )]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: firstLine.count))
        
        labelRevenue.attributedText = attributedText
    }
    
    fileprivate func saveRelease(date: String) {
        let firstLine = "\(LocalizableKeys.MovieDetail.releaseDate.getLocalized())\t"
        var dateText = firstLine
        dateText.append(date.formatDateString())
        
        let attributedText = NSMutableAttributedString(string: dateText)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppTheme.shared.colors.secondary,.font: UIFont.boldSystemFont(ofSize: 12 )]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: firstLine.count))
        labelDate.attributedText = attributedText
    }
}
