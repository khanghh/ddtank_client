package ddt.manager
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.analyze.VoteInfoAnalyzer;
   import ddt.data.analyze.VoteSubmitResultAnalyzer;
   import ddt.data.vote.VoteQuestionInfo;
   import ddt.view.vote.VoteView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class VoteManager extends EventDispatcher
   {
      
      public static var LOAD_COMPLETED:String = "loadCompleted";
      
      private static var vote:VoteManager;
       
      
      public var loadOver:Boolean = false;
      
      public var showVote:Boolean = true;
      
      public var count:int = 0;
      
      public var questionLength:int = 0;
      
      public var awardDic:Dictionary;
      
      private var voteView:VoteView;
      
      private var list:Dictionary;
      
      private var firstQuestionID:String;
      
      private var completeMessage:String;
      
      private var minGrade:int;
      
      private var maxGrade:int;
      
      private var voteId:String;
      
      private var allAnswer:String = "";
      
      private var answerArr:Array;
      
      private var isVoteComplete:Boolean;
      
      private var nowVoteQuestionInfo:VoteQuestionInfo;
      
      public function VoteManager()
      {
         answerArr = [];
         super();
      }
      
      public static function get Instance() : VoteManager
      {
         if(vote == null)
         {
            vote = new VoteManager();
         }
         return vote;
      }
      
      public function loadCompleted(param1:VoteInfoAnalyzer) : void
      {
         loadOver = true;
         list = param1.list;
         voteId = param1.voteId;
         firstQuestionID = param1.firstQuestionID;
         completeMessage = param1.completeMessage;
         minGrade = param1.minGrade;
         maxGrade = param1.maxGrade;
         questionLength = param1.questionLength;
         awardDic = param1.awardDic;
         dispatchEvent(new Event(LOAD_COMPLETED));
      }
      
      public function openVote() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade < minGrade || PlayerManager.Instance.Self.Grade > maxGrade)
         {
            return;
         }
         voteView = ComponentFactory.Instance.creatComponentByStylename("vote.VoteView");
         voteView.addEventListener(VoteView.OK_CLICK,__chosed);
         voteView.addEventListener(VoteView.VOTEVIEW_CLOSE,__voteViewCLose);
         if(SharedManager.Instance.voteData["userId"] == PlayerManager.Instance.Self.ID)
         {
            _loc1_ = SharedManager.Instance.voteData["voteId"];
            if(voteId == _loc1_)
            {
               count = SharedManager.Instance.voteData["voteProgress"] - 1;
               nextQuetion(SharedManager.Instance.voteData["voteQuestionID"]);
               answerArr = SharedManager.Instance.voteData["voteAnswer"];
            }
            else
            {
               nextQuetion(firstQuestionID);
            }
         }
         else
         {
            nextQuetion(firstQuestionID);
         }
      }
      
      private function __chosed(param1:Event) : void
      {
         answerArr.push(voteView.selectAnswer);
         nextQuetion(nowVoteQuestionInfo.nextQuestionID);
      }
      
      private function nextQuetion(param1:String) : void
      {
         count = Number(count) + 1;
         if(param1 != "0")
         {
            voteView.visible = false;
            nowVoteQuestionInfo = list[param1];
            voteView.info = nowVoteQuestionInfo;
            voteView.visible = true;
            LayerManager.Instance.addToLayer(voteView,3,true,1);
         }
         else
         {
            closeVote();
         }
      }
      
      public function closeVote() : void
      {
         loadOver = false;
         showVote = false;
         voteView.removeEventListener(VoteView.OK_CLICK,__chosed);
         voteView.dispose();
         sendToServer();
      }
      
      private function sendToServer() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < answerArr.length)
         {
            _loc2_ = new URLVariables();
            _loc2_["userId"] = PlayerManager.Instance.Self.ID;
            _loc2_["voteId"] = voteId;
            _loc2_["answerContent"] = answerArr[_loc3_];
            _loc2_["rnd"] = Math.random();
            _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VoteSubmitResult.ashx"),6,_loc2_,"POST");
            _loc1_.analyzer = new VoteSubmitResultAnalyzer(getResult);
            LoadResourceManager.Instance.startLoad(_loc1_);
            _loc3_++;
         }
      }
      
      private function getResult(param1:VoteSubmitResultAnalyzer) : void
      {
         if(isVoteComplete)
         {
            return;
         }
         if(param1.result == 1)
         {
            MessageTipManager.getInstance().show(completeMessage);
         }
         else
         {
            MessageTipManager.getInstance().show("投票失败!");
         }
         isVoteComplete = true;
      }
      
      private function __voteViewCLose(param1:Event) : void
      {
         voteView = null;
         loadOver = false;
         showVote = false;
         SharedManager.Instance.voteData["voteId"] = voteId;
         SharedManager.Instance.voteData["voteAnswer"] = answerArr;
         SharedManager.Instance.voteData["voteProgress"] = count;
         SharedManager.Instance.voteData["voteQuestionID"] = nowVoteQuestionInfo.questionID;
         SharedManager.Instance.voteData["userId"] = PlayerManager.Instance.Self.ID;
         SharedManager.Instance.save();
      }
   }
}
