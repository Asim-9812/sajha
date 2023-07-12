

class Api{

static const baseUrlLocal = 'http://192.168.101.110:82';
static const baseUrl = 'http://202.51.74.138:92';

/// User registration
static const userSignUp = '$baseUrl/api/AppUser/Register-User';
static const verifyOTP = '$baseUrl/api/AppUser/Verify-OTP';
static const resendOTP = '$baseUrl/api/AppUser/resend-otp';
static const setPassword = '$baseUrl/api/AppUser/Set-Password';

/// User login
static const userLogin = '$baseUrl/api/AppUser/Login';

/// forgot password
static const forgetPassword = '$baseUrl/api/AppUser/forget-password';
static const forgetPasswordVerifyOTP = '$baseUrl/api/AppUser/resetpasswordverifyotp';
static const resetPassword = '$baseUrl/api/AppUser/reset-password';

/// cancel user while register
static const removeUser = '$baseUrl/api/AppUser/remove-user';

/// Fetch user info
static const userInfo = '$baseUrl/api/AppUser/GetAppUserInfo';

/// update user Info
static const updateUser = '$baseUrl/api/AppUser/update-userprofile';

/// Fetch carousal images
static const getCarouselImg = '$baseUrl/api/ImageSlider/GetallImageSlider';

/// Fetch Book detail
static const bookDetail = '$baseUrl/api/BookDetails/GetBookDetailsbyid';


/// Fetch List of books
static const bookInfo = '$baseUrl/api/BookDetails/GetBookDetails';

/// Fetch book collection
static const getRecommendedBooks = '$baseUrl/api/BooksCollection/GetRecommendedBooks';
static const getBestSellingBooks = '$baseUrl/api/BooksCollection/GetBestSellerBooks';
static const getLatestBooks = '$baseUrl/api/BooksCollection/GetLatestBooks';
static const getFreeBooks = '$baseUrl/api/BooksCollection/GetFreeBooks';
static const getPremiumBooks = '$baseUrl/api/BooksCollection/GetPremiumBooks';

/// Search books
static const searchBook = '$baseUrl/api/BookDetails/SearchAPI';

/// book checkout
static const checkBook = '$baseUrl/api/AppUserBookList/CheckBook';
static const bookCheckout = '$baseUrl/api/AppUserBookList/AddUserBooks';


/// Purchase books
static const getBookList = '$baseUrl/api/AppUserBookList/UserBooks';
static const getBookPdf = '$baseUrl/api/AppUserBookList/UserBookPDF';


/// change password:
static const changePassword = '$baseUrl/api/AppUser/changepassword';

/// add comment:
static const addComment = '$baseUrl/api/Comment/AddComment';

/// rating
static const submitRating = '$baseUrl/api/Rating/AddRating';

/// favorite book
static const getFavoriteBook = '$baseUrl/api/Favourite/MyFavourite';
static const addFavoriteBook = '$baseUrl/api/Favourite/AddFavourite';
static const removeFavoriteBook = '$baseUrl/api/Favourite/DeleteFavourite';

/// search book genre
static const searchByGenre = '$baseUrl/api/BookDetails/SearchBooksbyGenre';

}