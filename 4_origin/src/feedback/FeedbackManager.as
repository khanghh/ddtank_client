package feedback
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.MD5;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.DailyButtunBar;
   import feedback.analyze.LoadFeedbackReplyAnalyzer;
   import feedback.data.FeedbackInfo;
   import feedback.data.FeedbackReplyInfo;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.DateUtils;
   
   public class FeedbackManager extends EventDispatcher
   {
      
      public static const OPEN_FEEDBACK_SUBMIT:String = "openFeedbackSubmit";
      
      public static const OPEN_FEEDBACK_REPLY:String = "openFeedbackReply";
      
      public static const CLOSE_FRAME:String = "closeFrame";
      
      private static var _instance:FeedbackManager;
       
      
      public var _feedbackInfo:FeedbackInfo;
      
      private var _feedbackTime:Date;
      
      private var _currentTime:Date;
      
      private var _currentOpenInt:int;
      
      public var _feedbackReplyData:DictionaryData;
      
      private var _isReply:Boolean;
      
      private var _isSubmitTime:Boolean;
      
      private var _removeFeedbackInfoId:String;
      
      public function FeedbackManager()
      {
         super();
      }
      
      public static function get instance() : FeedbackManager
      {
         if(_instance == null)
         {
            _instance = new FeedbackManager();
         }
         return _instance;
      }
      
      public function get feedbackInfo() : FeedbackInfo
      {
         if(!_feedbackInfo)
         {
            _feedbackInfo = new FeedbackInfo();
         }
         return _feedbackInfo;
      }
      
      public function get feedbackReplyData() : DictionaryData
      {
         return _feedbackReplyData;
      }
      
      public function set feedbackReplyData(param1:DictionaryData) : void
      {
         if(_feedbackReplyData)
         {
            _feedbackReplyData.removeEventListener("add",feedbackReplyDataAdd);
            _feedbackReplyData.removeEventListener("remove",feedbackReplyDataRemove);
         }
         _feedbackReplyData = param1;
         _feedbackReplyData.addEventListener("add",feedbackReplyDataAdd);
         _feedbackReplyData.addEventListener("remove",feedbackReplyDataRemove);
         SocketManager.Instance.addEventListener(PkgEvent.format(213),feedbackReplyBySocket);
         checkFeedbackReplyData();
      }
      
      public function setupFeedbackData(param1:LoadFeedbackReplyAnalyzer) : void
      {
         if(PathManager.solveFeedbackEnable())
         {
            feedbackReplyData = param1.listData;
         }
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["userid"] = PlayerManager.Instance.Self.ID;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestTime.ashx"),6,_loc3_);
         _loc2_.addEventListener("complete",__loaderComplete);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      private function __loaderComplete(param1:LoaderEvent) : void
      {
         param1.currentTarget.removeEventListener("complete",__loaderComplete);
         if(param1.loader.content == 0)
         {
            return;
         }
         var _loc2_:Array = String(param1.loader.content).split(",");
         if(_loc2_[0])
         {
            if(_loc2_[0] == 0)
            {
               _feedbackTime = null;
            }
            else
            {
               _feedbackTime = DateUtils.getDateByStr(_loc2_[0]);
            }
         }
         if(_loc2_[1])
         {
            _currentTime = DateUtils.getDateByStr(_loc2_[1]);
         }
         if(_loc2_[2])
         {
            _currentOpenInt = Number(_loc2_[2]);
         }
      }
      
      private function feedbackReplyBySocket(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:FeedbackReplyInfo = new FeedbackReplyInfo();
         _loc2_.questionId = _loc3_.readUTF();
         _loc2_.replyId = _loc3_.readInt();
         _loc2_.occurrenceDate = _loc3_.readUTF();
         _loc2_.questionTitle = _loc3_.readUTF();
         _loc2_.questionContent = _loc3_.readUTF();
         _loc2_.replyContent = _loc3_.readUTF();
         _loc2_.stopReply = _loc3_.readUTF();
         _feedbackReplyData.add(_loc2_.questionId + "_" + _loc2_.replyId,_loc2_);
         stopReplyEvt(_loc2_.stopReply);
      }
      
      private function stopReplyEvt(param1:String) : void
      {
         var _loc3_:Object = {};
         _loc3_.stopReply = param1;
         var _loc2_:FeedbackEvent = new FeedbackEvent("feedbackStopReply",_loc3_);
         dispatchEvent(_loc2_);
      }
      
      private function feedbackReplyDataAdd(param1:DictionaryEvent) : void
      {
         checkFeedbackReplyData();
      }
      
      private function feedbackReplyDataRemove(param1:DictionaryEvent) : void
      {
         checkFeedbackReplyData();
      }
      
      private function checkFeedbackReplyData() : void
      {
         if(_feedbackReplyData.length <= 0)
         {
            _isReply = false;
            DailyButtunBar.Insance.setComplainGlow(false);
         }
         else
         {
            _isReply = true;
            DailyButtunBar.Insance.setComplainGlow(true);
         }
      }
      
      public function examineTime() : Boolean
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(!_feedbackTime)
         {
            return true;
         }
         if(_loc1_.time - _feedbackTime.time >= 2100000)
         {
            return true;
         }
         return false;
      }
      
      public function show() : void
      {
         if(!_isReply)
         {
            if(_currentOpenInt >= 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.MaxReferTimes"));
               return;
            }
            if(!_currentTime && !_feedbackTime)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("BaseStateCreator.LoadingTip"));
               return;
            }
            if(examineTime())
            {
               dispatchEvent(new CEvent("openFeedbackSubmit"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.SystemsAnalysis"));
            }
         }
         else
         {
            dispatchEvent(new CEvent("openFeedbackReply"));
         }
      }
      
      public function showFeedback() : void
      {
         show();
      }
      
      private function openFeedbackSubmitView() : void
      {
         dispatchEvent(new CEvent("openFeedbackSubmit"));
      }
      
      private function openFeedbackReplyView() : void
      {
         dispatchEvent(new CEvent("openFeedbackReply"));
      }
      
      public function closeFrame() : void
      {
         dispatchEvent(new CEvent("closeFrame"));
      }
      
      public function quickReport(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:FeedbackInfo = new FeedbackInfo();
         _loc4_.question_title = LanguageMgr.GetTranslation("quickReport.complain.lan");
         _loc4_.question_content = "[" + param1 + "]" + "[" + param2 + "]:" + param3;
         _loc4_.occurrence_date = DateUtils.dateFormat(new Date());
         _loc4_.question_type = 9;
         _loc4_.report_url = param2;
         _loc4_.report_user_name = param2;
         FeedbackManager.instance.submitFeedbackInfo(_loc4_);
      }
      
      public function submitFeedbackInfo(param1:FeedbackInfo) : void
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_.user_id = PlayerManager.Instance.Self.ID.toString();
         _loc3_.user_name = PlayerManager.Instance.Self.LoginName;
         _loc3_.user_nick_name = PlayerManager.Instance.Self.NickName;
         _loc3_.question_title = param1.question_title;
         _loc3_.question_content = param1.question_content;
         _loc3_.occurrence_date = param1.occurrence_date;
         _loc3_.question_type = param1.question_type.toString();
         _loc3_.goods_get_method = param1.goods_get_method;
         _loc3_.goods_get_date = param1.goods_get_date;
         _loc3_.charge_order_id = param1.charge_order_id;
         _loc3_.charge_method = param1.charge_method;
         _loc3_.charge_moneys = param1.charge_moneys.toString();
         _loc3_.activity_is_error = param1.activity_is_error.toString();
         _loc3_.activity_name = param1.activity_name;
         _loc3_.report_user_name = param1.report_user_name;
         _loc3_.report_url = param1.report_url;
         _loc3_.user_full_name = param1.user_full_name;
         _loc3_.user_phone = param1.user_phone;
         _loc3_.complaints_title = param1.complaints_title;
         _loc3_.complaints_source = param1.complaints_source;
         _loc3_.token = MD5.hash(PlayerManager.Instance.Self.ID.toString() + PlayerManager.Instance.Self.ZoneID.toString() + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestion.ashx"),6,_loc3_,"POST");
         _loc2_.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(_loc2_);
         closeFrame();
         _isSubmitTime = true;
      }
      
      public function continueSubmit(param1:String, param2:int, param3:String) : void
      {
         _removeFeedbackInfoId = param1 + "_" + param2;
         var _loc5_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc5_.pass = MD5.hash(PlayerManager.Instance.Self.ID + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         _loc5_.userid = PlayerManager.Instance.Self.ID;
         _loc5_.nick_name = PlayerManager.Instance.Self.NickName;
         _loc5_.question_id = param1;
         _loc5_.reply_id = param2;
         _loc5_.reply_content = param3;
         _loc5_.token = MD5.hash(param1.toString() + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceReply.ashx"),6,_loc5_,"POST");
         _loc4_.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(_loc4_);
         closeFrame();
      }
      
      public function delPosts(param1:String, param2:int, param3:int, param4:String) : void
      {
         _removeFeedbackInfoId = param1 + "_" + param2;
         var _loc6_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc6_.pass = MD5.hash(PlayerManager.Instance.Self.ID + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         _loc6_.userid = PlayerManager.Instance.Self.ID;
         _loc6_.nick_name = PlayerManager.Instance.Self.NickName;
         _loc6_.question_id = param1;
         _loc6_.reply_id = param2;
         _loc6_.appraisal_grade = param3;
         _loc6_.appraisal_content = param4;
         _loc6_.token = MD5.hash(param1.toString() + param3 + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var _loc5_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestionAppraisal.ashx"),6,_loc6_,"POST");
         _loc5_.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(_loc5_);
         closeFrame();
      }
      
      private function __onLoadFreeBackComplete(param1:LoaderEvent) : void
      {
         if(param1.loader.content == 1)
         {
            if(_isSubmitTime)
            {
               _feedbackTime = TimeManager.Instance.Now();
               _currentOpenInt = Number(_currentOpenInt) + 1;
            }
            if(_removeFeedbackInfoId)
            {
               _feedbackReplyData.remove(_removeFeedbackInfoId);
               _removeFeedbackInfoId = null;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.ThankReferQuestion"));
         }
         else if(param1.loader.content == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.MaxReferTimes"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.SystemBusy"));
         }
         _isSubmitTime = false;
      }
   }
}
