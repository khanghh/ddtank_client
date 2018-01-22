package feedback.data
{
   public class FeedbackInfo
   {
       
      
      private var _userID:int;
      
      private var _userName:String;
      
      private var _userNickName:String;
      
      private var _questionTitle:String;
      
      private var _questionContent:String;
      
      private var _occurrenceDate:String;
      
      private var _questionType:int;
      
      private var _goodsGetMethod:String;
      
      private var _goodsGetDate:String;
      
      private var _chargeOrderId:String;
      
      private var _chargeMethod:String;
      
      private var _chargeMoneys:Number;
      
      private var _activityIsError:Boolean = true;
      
      private var _activityName:String;
      
      private var _reportUserName:String;
      
      private var _reportUrl:String;
      
      private var _userFullName:String;
      
      private var _userPhone:String;
      
      private var _complaintsTitle:String;
      
      private var _complaintsSource:String;
      
      private var _appraisalGrade:String;
      
      private var _appraisalContent:String;
      
      public function FeedbackInfo()
      {
         super();
      }
      
      public function get question_title() : String
      {
         return _questionTitle;
      }
      
      public function set question_title(param1:String) : void
      {
         _questionTitle = param1;
      }
      
      public function get question_content() : String
      {
         return _questionContent;
      }
      
      public function set question_content(param1:String) : void
      {
         _questionContent = param1;
      }
      
      public function get occurrence_date() : String
      {
         return _occurrenceDate;
      }
      
      public function set occurrence_date(param1:String) : void
      {
         _occurrenceDate = param1;
      }
      
      public function get question_type() : int
      {
         return _questionType;
      }
      
      public function set question_type(param1:int) : void
      {
         _questionType = param1;
      }
      
      public function get goods_get_method() : String
      {
         return _goodsGetMethod;
      }
      
      public function set goods_get_method(param1:String) : void
      {
         _goodsGetMethod = param1;
      }
      
      public function get goods_get_date() : String
      {
         return _goodsGetDate;
      }
      
      public function set goods_get_date(param1:String) : void
      {
         _goodsGetDate = param1;
      }
      
      public function get charge_order_id() : String
      {
         return _chargeOrderId;
      }
      
      public function set charge_order_id(param1:String) : void
      {
         _chargeOrderId = param1;
      }
      
      public function get charge_method() : String
      {
         return _chargeMethod;
      }
      
      public function set charge_method(param1:String) : void
      {
         _chargeMethod = param1;
      }
      
      public function get charge_moneys() : Number
      {
         return _chargeMoneys;
      }
      
      public function set charge_moneys(param1:Number) : void
      {
         _chargeMoneys = param1;
      }
      
      public function get activity_is_error() : Boolean
      {
         return _activityIsError;
      }
      
      public function set activity_is_error(param1:Boolean) : void
      {
         _activityIsError = param1;
      }
      
      public function get activity_name() : String
      {
         return _activityName;
      }
      
      public function set activity_name(param1:String) : void
      {
         _activityName = param1;
      }
      
      public function get report_user_name() : String
      {
         return _reportUserName;
      }
      
      public function set report_user_name(param1:String) : void
      {
         _reportUserName = param1;
      }
      
      public function get report_url() : String
      {
         return _reportUrl;
      }
      
      public function set report_url(param1:String) : void
      {
         _reportUrl = param1;
      }
      
      public function get user_full_name() : String
      {
         return _userFullName;
      }
      
      public function set user_full_name(param1:String) : void
      {
         _userFullName = param1;
      }
      
      public function get user_phone() : String
      {
         return _userPhone;
      }
      
      public function set user_phone(param1:String) : void
      {
         _userPhone = param1;
      }
      
      public function get complaints_title() : String
      {
         return _complaintsTitle;
      }
      
      public function set complaints_title(param1:String) : void
      {
         _complaintsTitle = param1;
      }
      
      public function get complaints_source() : String
      {
         return _complaintsSource;
      }
      
      public function set complaints_source(param1:String) : void
      {
         _complaintsSource = param1;
      }
      
      public function get appraisal_grade() : String
      {
         return _appraisalGrade;
      }
      
      public function set appraisal_grade(param1:String) : void
      {
         _appraisalGrade = param1;
      }
      
      public function get appraisal_content() : String
      {
         return _appraisalContent;
      }
      
      public function set appraisal_content(param1:String) : void
      {
         _appraisalContent = param1;
      }
      
      public function get user_id() : int
      {
         return _userID;
      }
      
      public function set user_id(param1:int) : void
      {
         _userID = param1;
      }
      
      public function get user_name() : String
      {
         return _userName;
      }
      
      public function set user_name(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get user_nick_name() : String
      {
         return _userNickName;
      }
      
      public function set user_nick_name(param1:String) : void
      {
         _userNickName = param1;
      }
   }
}
