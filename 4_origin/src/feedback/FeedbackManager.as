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
      
      public function set feedbackReplyData(value:DictionaryData) : void
      {
         if(_feedbackReplyData)
         {
            _feedbackReplyData.removeEventListener("add",feedbackReplyDataAdd);
            _feedbackReplyData.removeEventListener("remove",feedbackReplyDataRemove);
         }
         _feedbackReplyData = value;
         _feedbackReplyData.addEventListener("add",feedbackReplyDataAdd);
         _feedbackReplyData.addEventListener("remove",feedbackReplyDataRemove);
         SocketManager.Instance.addEventListener(PkgEvent.format(213),feedbackReplyBySocket);
         checkFeedbackReplyData();
      }
      
      public function setupFeedbackData(analyzer:LoadFeedbackReplyAnalyzer) : void
      {
         if(PathManager.solveFeedbackEnable())
         {
            feedbackReplyData = analyzer.listData;
         }
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["userid"] = PlayerManager.Instance.Self.ID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestTime.ashx"),6,args);
         loader.addEventListener("complete",__loaderComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __loaderComplete(event:LoaderEvent) : void
      {
         event.currentTarget.removeEventListener("complete",__loaderComplete);
         if(event.loader.content == 0)
         {
            return;
         }
         var tempTime:Array = String(event.loader.content).split(",");
         if(tempTime[0])
         {
            if(tempTime[0] == 0)
            {
               _feedbackTime = null;
            }
            else
            {
               _feedbackTime = DateUtils.getDateByStr(tempTime[0]);
            }
         }
         if(tempTime[1])
         {
            _currentTime = DateUtils.getDateByStr(tempTime[1]);
         }
         if(tempTime[2])
         {
            _currentOpenInt = Number(tempTime[2]);
         }
      }
      
      private function feedbackReplyBySocket(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var feedbackReplyInfo:FeedbackReplyInfo = new FeedbackReplyInfo();
         feedbackReplyInfo.questionId = pkg.readUTF();
         feedbackReplyInfo.replyId = pkg.readInt();
         feedbackReplyInfo.occurrenceDate = pkg.readUTF();
         feedbackReplyInfo.questionTitle = pkg.readUTF();
         feedbackReplyInfo.questionContent = pkg.readUTF();
         feedbackReplyInfo.replyContent = pkg.readUTF();
         feedbackReplyInfo.stopReply = pkg.readUTF();
         _feedbackReplyData.add(feedbackReplyInfo.questionId + "_" + feedbackReplyInfo.replyId,feedbackReplyInfo);
         stopReplyEvt(feedbackReplyInfo.stopReply);
      }
      
      private function stopReplyEvt(str:String) : void
      {
         var obj:Object = {};
         obj.stopReply = str;
         var feedEvt:FeedbackEvent = new FeedbackEvent("feedbackStopReply",obj);
         dispatchEvent(feedEvt);
      }
      
      private function feedbackReplyDataAdd(event:DictionaryEvent) : void
      {
         checkFeedbackReplyData();
      }
      
      private function feedbackReplyDataRemove(event:DictionaryEvent) : void
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
         var timeTime:Date = TimeManager.Instance.Now();
         if(!_feedbackTime)
         {
            return true;
         }
         if(timeTime.time - _feedbackTime.time >= 2100000)
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
      
      public function quickReport(channel:String, name:String, message:String) : void
      {
         var feedbackInfo:FeedbackInfo = new FeedbackInfo();
         feedbackInfo.question_title = LanguageMgr.GetTranslation("quickReport.complain.lan");
         feedbackInfo.question_content = "[" + channel + "]" + "[" + name + "]:" + message;
         feedbackInfo.occurrence_date = DateUtils.dateFormat(new Date());
         feedbackInfo.question_type = 9;
         feedbackInfo.report_url = name;
         feedbackInfo.report_user_name = name;
         FeedbackManager.instance.submitFeedbackInfo(feedbackInfo);
      }
      
      public function submitFeedbackInfo($feedbackInfo:FeedbackInfo) : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args.user_id = PlayerManager.Instance.Self.ID.toString();
         args.user_name = PlayerManager.Instance.Self.LoginName;
         args.user_nick_name = PlayerManager.Instance.Self.NickName;
         args.question_title = $feedbackInfo.question_title;
         args.question_content = $feedbackInfo.question_content;
         args.occurrence_date = $feedbackInfo.occurrence_date;
         args.question_type = $feedbackInfo.question_type.toString();
         args.goods_get_method = $feedbackInfo.goods_get_method;
         args.goods_get_date = $feedbackInfo.goods_get_date;
         args.charge_order_id = $feedbackInfo.charge_order_id;
         args.charge_method = $feedbackInfo.charge_method;
         args.charge_moneys = $feedbackInfo.charge_moneys.toString();
         args.activity_is_error = $feedbackInfo.activity_is_error.toString();
         args.activity_name = $feedbackInfo.activity_name;
         args.report_user_name = $feedbackInfo.report_user_name;
         args.report_url = $feedbackInfo.report_url;
         args.user_full_name = $feedbackInfo.user_full_name;
         args.user_phone = $feedbackInfo.user_phone;
         args.complaints_title = $feedbackInfo.complaints_title;
         args.complaints_source = $feedbackInfo.complaints_source;
         args.token = MD5.hash(PlayerManager.Instance.Self.ID.toString() + PlayerManager.Instance.Self.ZoneID.toString() + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestion.ashx"),6,args,"POST");
         loader.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(loader);
         closeFrame();
         _isSubmitTime = true;
      }
      
      public function continueSubmit(questionId:String, replyId:int, questionContent:String) : void
      {
         _removeFeedbackInfoId = questionId + "_" + replyId;
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args.pass = MD5.hash(PlayerManager.Instance.Self.ID + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         args.userid = PlayerManager.Instance.Self.ID;
         args.nick_name = PlayerManager.Instance.Self.NickName;
         args.question_id = questionId;
         args.reply_id = replyId;
         args.reply_content = questionContent;
         args.token = MD5.hash(questionId.toString() + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceReply.ashx"),6,args,"POST");
         loader.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(loader);
         closeFrame();
      }
      
      public function delPosts(questionId:String, replyId:int, appraisalGrade:int, AppraisalContent:String) : void
      {
         _removeFeedbackInfoId = questionId + "_" + replyId;
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args.pass = MD5.hash(PlayerManager.Instance.Self.ID + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         args.userid = PlayerManager.Instance.Self.ID;
         args.nick_name = PlayerManager.Instance.Self.NickName;
         args.question_id = questionId;
         args.reply_id = replyId;
         args.appraisal_grade = appraisalGrade;
         args.appraisal_content = AppraisalContent;
         args.token = MD5.hash(questionId.toString() + appraisalGrade + "3kjf2jfwj93pj22jfsl11jjoe12oij");
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("AdvanceQuestionAppraisal.ashx"),6,args,"POST");
         loader.addEventListener("complete",__onLoadFreeBackComplete);
         LoadResourceManager.Instance.startLoad(loader);
         closeFrame();
      }
      
      private function __onLoadFreeBackComplete(event:LoaderEvent) : void
      {
         if(event.loader.content == 1)
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
         else if(event.loader.content == -1)
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
