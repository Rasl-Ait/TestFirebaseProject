
import Foundation

protocol CellHeaderProtocol {
	associatedtype CellType
	
	var cellModels: [CellType] { get }
}
