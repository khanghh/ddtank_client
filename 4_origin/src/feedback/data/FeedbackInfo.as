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
      
      public function set question_title(value:String) : void
      {
         _questionTitle = value;
      }
      
      public function get question_content() : String
      {
         return _questionContent;
      }
      
      public function set question_content(value:String) : void
      {
         _questionContent = value;
      }
      
      public function get occurrence_date() : String
      {
         return _occurrenceDate;
      }
      
      public function set occurrence_date(value:String) : void
      {
         _occurrenceDate = value;
      }
      
      public function get question_type() : int
      {
         return _questionType;
      }
      
      public function set question_type(value:int) : void
      {
         _questionType = value;
      }
      
      public function get goods_get_method() : String
      {
         return _goodsGetMethod;
      }
      
      public function set goods_get_method(value:String) : void
      {
         _goodsGetMethod = value;
      }
      
      public function get goods_get_date() : String
      {
         return _goodsGetDate;
      }
      
      public function set goods_get_date(value:String) : void
      {
         _goodsGetDate = value;
      }
      
      public function get charge_order_id() : String
      {
         return _chargeOrderId;
      }
      
      public function set charge_order_id(value:String) : void
      {
         _chargeOrderId = value;
      }
      
      public function get charge_method() : String
      {
         return _chargeMethod;
      }
      
      public function set charge_method(value:String) : void
      {
         _chargeMethod = value;
      }
      
      public function get charge_moneys() : Number
      {
         return _chargeMoneys;
      }
      
      public function set charge_moneys(value:Number) : void
      {
         _chargeMoneys = value;
      }
      
      public function get activity_is_error() : Boolean
      {
         return _activityIsError;
      }
      
      public function set activity_is_error(value:Boolean) : void
      {
         _activityIsError = value;
      }
      
      public function get activity_name() : String
      {
         return _activityName;
      }
      
      public function set activity_name(value:String) : void
      {
         _activityName = value;
      }
      
      public function get report_user_name() : String
      {
         return _reportUserName;
      }
      
      public function set report_user_name(value:String) : void
      {
         _reportUserName = value;
      }
      
      public function get report_url() : String
      {
         return _reportUrl;
      }
      
      public function set report_url(value:String) : void
      {
         _reportUrl = value;
      }
      
      public function get user_full_name() : String
      {
         return _userFullName;
      }
      
      public function set user_full_name(value:String) : void
      {
         _userFullName = value;
      }
      
      public function get user_phone() : String
      {
         return _userPhone;
      }
      
      public function set user_phone(value:String) : void
      {
         _userPhone = value;
      }
      
      public function get complaints_title() : String
      {
         return _complaintsTitle;
      }
      
      public function set complaints_title(value:String) : void
      {
         _complaintsTitle = value;
      }
      
      public function get complaints_source() : String
      {
         return _complaintsSource;
      }
      
      public function set complaints_source(value:String) : void
      {
         _complaintsSource = value;
      }
      
      public function get appraisal_grade() : String
      {
         return _appraisalGrade;
      }
      
      public function set appraisal_grade(value:String) : void
      {
         _appraisalGrade = value;
      }
      
      public function get appraisal_content() : String
      {
         return _appraisalContent;
      }
      
      public function set appraisal_content(value:String) : void
      {
         _appraisalContent = value;
      }
      
      public function get user_id() : int
      {
         return _userID;
      }
      
      public function set user_id(value:int) : void
      {
         _userID = value;
      }
      
      public function get user_name() : String
      {
         return _userName;
      }
      
      public function set user_name(value:String) : void
      {
         _userName = value;
      }
      
      public function get user_nick_name() : String
      {
         return _userNickName;
      }
      
      public function set user_nick_name(value:String) : void
      {
         _userNickName = value;
      }
   }
}
