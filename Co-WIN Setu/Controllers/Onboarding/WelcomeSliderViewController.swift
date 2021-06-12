import UIKit

class WelcomeSliderViewController: UIViewController
{
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let sliderArray = ["Welcome1","Welcome2","Welcome3","Welcome4","Welcome5","Welcome6","Welcome7"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sliderCollectionView.reloadData()
    }
    
    // MARK: - PageControl, Previous and Next Button
    
    @IBAction func previousButtonPress(_ sender: UIButton)
    {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func nextButtonPress(_ sender: UIButton)
    {
        let nextIndex = min(pageControl.currentPage + 1, sliderArray.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if (sliderCollectionView.cellForItem(at: indexPath) != nil)
        {
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            UIApplication.shared.windows[0].rootViewController = vc
        }
    }
    
    @IBAction func pageControl(_ sender: UIPageControl)
    {
        pageControl.currentPage = 0
        pageControl.numberOfPages = 7
    }
    
    // MARK: - Scrolling Collection View
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        coordinator.animate(alongsideTransition: { (_) in
            if self.pageControl.currentPage == 0
            {
                self.sliderCollectionView.contentOffset = .zero
            }
            else
            {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
}

// MARK: - Collection View

extension WelcomeSliderViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sliderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeSliderCollectionViewCell", for: indexPath) as! WelcomeSliderCollectionViewCell
        cell.sliderImageView.contentMode = .scaleAspectFill
        cell.sliderImageView.image = UIImage(named: sliderArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
}
