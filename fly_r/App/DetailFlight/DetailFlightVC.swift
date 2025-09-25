import UIKit
import Combine

final class DetailFlightVC: ControllerModal {
    
    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let originName = UILabel()
    private let originCode = UILabel()
    private let destinationName = UILabel()
    private let destinationCode = UILabel()
    private let viewPlane = ViewPlane()
    private let departTitle = UILabel()
    private let departDate = UILabel()
    private let departTime = UILabel()
    private let arriveTitle = UILabel()
    private let arriveDate = UILabel()
    private let arriveTime = UILabel()
    private let separatorOne = Separator()
    private let salerTitle = UILabel()
    private let salerValue = UILabel()
    private let separatorTwo = Separator()
    private let durationTitle = UILabel()
    private let durationValue = UILabel()
    private let separatorThree = Separator()
    private let distanceTitle = UILabel()
    private let distanceValue = UILabel()
    private let separatorFour = Separator()
    private let price = UILabel()
    
    private var cityFrom: City!
    private var cityTo: City!
    private var flight: Flight!
    
    init(
        cityFrom: City,
        cityTo: City,
        flight: Flight
    ) {
        super.init(nibName: nil, bundle: nil)
        self.cityFrom = cityFrom
        self.cityTo = cityTo
        self.flight = flight
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        setView()
    }
    
    deinit { print("deinit DetailTicketVC") }
    
    private func setView() {
        setOriginCode()
        setOriginName()
        setDestinationCode()
        setDestinationName()
        setDepartDate()
        setDepartTime()
        setArriveDate()
        setArriveTime()
        setSalerValue()
        setDurationValue()
        setDistanceValue()
        setPrice()
    }
    
    private func setOriginCode() {
        originCode.text = flight.originCode
    }
    
    private func setOriginName() {
        originName.text = cityFrom?.name
    }
    
    private func setDestinationCode() {
        destinationCode.text = flight.destinationCode
    }
    
    private func setDestinationName() {
        destinationName.text = cityTo?.name
    }
    
    private func setDepartDate() {
        if let flight = flight {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: flight.departDate)
            departDate.text = date?.convertToString(format: .one)
        }
    }
    
    private func setDepartTime() {
        departTime.text = "12:12"
    }
    
    private func setArriveDate() {
        if let flight = flight {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: flight.departDate)
            arriveDate.text = date?.convertToString(format: .one)
        }
    }
    
    private func setArriveTime() {
        arriveTime.text = "12:12"
    }
    
    private func setSalerValue() {
        salerValue.text = flight.gate
    }
    
    private func setDurationValue() {
        durationValue.text = "\(flight.duration)"
    }
    
    private func setDistanceValue() {
        distanceValue.text = "\(flight.distance)"
    }
    
    private func setPrice() {
        price.text = "\(flight.price) ₽"
    }
}


extension DetailFlightVC {

    private func createSubviews() {
        createScroll()
        createViewBack()
        createOriginName()
        createOriginCode()
        createDestinationName()
        createDestinationCode()
        createViewPlane()
        createDepartTitle()
        createDepartDate()
        createDepartTime()
        createArriveTitle()
        createArriveDate()
        createArriveTime()
        createSeparatorOne()
        createSalerTitle()
        createSalerValue()
        createSeparatorTwo()
        createDurationTitle()
        createDurationValue()
        createSeparatorThree()
        createDistanceTitle()
        createDistanceValue()
        createSeparatorFour()
        createPrice()
    }
    
    private func createScroll() {
        view.addSubview(scroll)
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        //
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createViewBack() {
        scroll.addSubview(viewBack)
        //
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        viewBack.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        viewBack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewBack.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        viewBack.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
    }
    
    private func createOriginName() {
        viewBack.addSubview(originName)
        originName.textColor = .white
        originName.font = UIFont.systemFont(
            ofSize: 18,
            weight: .medium
        )
        //
        originName.translatesAutoresizingMaskIntoConstraints = false
        originName.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 16).isActive = true
        originName.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createOriginCode() {
        viewBack.addSubview(originCode)
        originCode.textColor = .gray
        originCode.font = UIFont.systemFont(
            ofSize: 16,
            weight: .light
        )
        //
        originCode.translatesAutoresizingMaskIntoConstraints = false
        originCode.topAnchor.constraint(equalTo: originName.bottomAnchor, constant: 4).isActive = true
        originCode.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDestinationName() {
        viewBack.addSubview(destinationName)
        destinationName.textColor = .gray
        destinationName.font = UIFont.systemFont(
            ofSize: 18,
            weight: .medium
        )
        //
        destinationName.translatesAutoresizingMaskIntoConstraints = false
        destinationName.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 16).isActive = true
        destinationName.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createDestinationCode() {
        viewBack.addSubview(destinationCode)
        destinationCode.textColor = .white
        destinationCode.font = UIFont.systemFont(
            ofSize: 16,
            weight: .light
        )
        //
        destinationCode.translatesAutoresizingMaskIntoConstraints = false
        destinationCode.topAnchor.constraint(equalTo: destinationName.bottomAnchor, constant: 4).isActive = true
        destinationCode.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createViewPlane() {
        viewBack.addSubview(viewPlane)
        //
        viewPlane.translatesAutoresizingMaskIntoConstraints = false
        viewPlane.topAnchor.constraint(equalTo: originCode.bottomAnchor, constant: 16).isActive = true
        viewPlane.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        viewPlane.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createDepartTitle() {
        viewBack.addSubview(departTitle)
        departTitle.textColor = .darkGray
        departTitle.text = "Depart"
        departTitle.font = UIFont.systemFont(
            ofSize: 12,
            weight: .regular
        )
        //
        departTitle.translatesAutoresizingMaskIntoConstraints = false
        departTitle.topAnchor.constraint(equalTo: viewPlane.bottomAnchor, constant: 16).isActive = true
        departTitle.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDepartDate() {
        viewBack.addSubview(departDate)
        departDate.textColor = .gray
        departDate.font = UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
        //
        departDate.translatesAutoresizingMaskIntoConstraints = false
        departDate.topAnchor.constraint(equalTo: departTitle.bottomAnchor, constant: 4).isActive = true
        departDate.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDepartTime() {
        viewBack.addSubview(departTime)
        departTime.textColor = .lightGray
        departTime.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        //
        departTime.translatesAutoresizingMaskIntoConstraints = false
        departTime.topAnchor.constraint(equalTo: departDate.bottomAnchor, constant: 4).isActive = true
        departTime.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createArriveTitle() {
        viewBack.addSubview(arriveTitle)
        arriveTitle.textColor = .darkGray
        arriveTitle.text = "Arrive"
        arriveTitle.font = UIFont.systemFont(
            ofSize: 12,
            weight: .regular
        )
        //
        arriveTitle.translatesAutoresizingMaskIntoConstraints = false
        arriveTitle.topAnchor.constraint(equalTo: departTitle.topAnchor).isActive = true
        arriveTitle.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createArriveDate() {
        viewBack.addSubview(arriveDate)
        arriveDate.textColor = .gray
        arriveDate.font = UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
        //
        arriveDate.translatesAutoresizingMaskIntoConstraints = false
        arriveDate.topAnchor.constraint(equalTo: arriveTitle.bottomAnchor, constant: 4).isActive = true
        arriveDate.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createArriveTime() {
        viewBack.addSubview(arriveTime)
        arriveTime.textColor = .lightGray
        arriveTime.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        //
        arriveTime.translatesAutoresizingMaskIntoConstraints = false
        arriveTime.topAnchor.constraint(equalTo: arriveDate.bottomAnchor, constant: 4).isActive = true
        arriveTime.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createSeparatorOne() {
        viewBack.addSubview(separatorOne)
        //
        separatorOne.translatesAutoresizingMaskIntoConstraints = false
        separatorOne.topAnchor.constraint(equalTo: departTime.bottomAnchor, constant: 16).isActive = true
        separatorOne.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separatorOne.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createSalerTitle() {
        viewBack.addSubview(salerTitle)
        salerTitle.textColor = .gray
        salerTitle.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        salerTitle.text = "Saler"
        //
        salerTitle.translatesAutoresizingMaskIntoConstraints = false
        salerTitle.topAnchor.constraint(equalTo: separatorOne.bottomAnchor, constant: 16).isActive = true
        salerTitle.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createSalerValue() {
        viewBack.addSubview(salerValue)
        salerValue.textColor = .gray
        salerValue.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        //
        salerValue.translatesAutoresizingMaskIntoConstraints = false
        salerValue.topAnchor.constraint(equalTo: separatorOne.bottomAnchor, constant: 16).isActive = true
        salerValue.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createSeparatorTwo() {
        viewBack.addSubview(separatorTwo)
        //
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        separatorTwo.topAnchor.constraint(equalTo: salerTitle.bottomAnchor, constant: 16).isActive = true
        separatorTwo.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separatorTwo.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
        
    private func createDurationTitle() {
        viewBack.addSubview(durationTitle)
        durationTitle.textColor = .gray
        durationTitle.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        durationTitle.text = "Duration"
        //
        durationTitle.translatesAutoresizingMaskIntoConstraints = false
        durationTitle.topAnchor.constraint(equalTo: separatorTwo.bottomAnchor, constant: 16).isActive = true
        durationTitle.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDurationValue() {
        viewBack.addSubview(durationValue)
        durationValue.textColor = .gray
        durationValue.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        durationValue.text = "Duration"
        //
        durationValue.translatesAutoresizingMaskIntoConstraints = false
        durationValue.topAnchor.constraint(equalTo: separatorTwo.bottomAnchor, constant: 16).isActive = true
        durationValue.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createSeparatorThree() {
        viewBack.addSubview(separatorThree)
        //
        separatorThree.translatesAutoresizingMaskIntoConstraints = false
        separatorThree.topAnchor.constraint(equalTo: durationTitle.bottomAnchor, constant: 16).isActive = true
        separatorThree.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separatorThree.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createDistanceTitle() {
        viewBack.addSubview(distanceTitle)
        distanceTitle.textColor = .gray
        distanceTitle.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        distanceTitle.text = "Distance"
        //
        distanceTitle.translatesAutoresizingMaskIntoConstraints = false
        distanceTitle.topAnchor.constraint(equalTo: separatorThree.bottomAnchor, constant: 16).isActive = true
        distanceTitle.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDistanceValue() {
        viewBack.addSubview(distanceValue)
        distanceValue.textColor = .gray
        distanceValue.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        distanceValue.text = "Duration"
        //
        distanceValue.translatesAutoresizingMaskIntoConstraints = false
        distanceValue.topAnchor.constraint(equalTo: separatorThree.bottomAnchor, constant: 16).isActive = true
        distanceValue.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createSeparatorFour() {
        viewBack.addSubview(separatorFour)
        //
        separatorFour.translatesAutoresizingMaskIntoConstraints = false
        separatorFour.topAnchor.constraint(equalTo: distanceTitle.bottomAnchor, constant: 16).isActive = true
        separatorFour.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separatorFour.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createPrice() {
        viewBack.addSubview(price)
        price.textColor = .white
        price.font = UIFont.systemFont(
            ofSize: 28,
            weight: .heavy
        )
        //
        price.translatesAutoresizingMaskIntoConstraints = false
        price.topAnchor.constraint(equalTo: separatorFour.bottomAnchor, constant: 24).isActive = true
        price.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -16).isActive = true
        price.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
}
