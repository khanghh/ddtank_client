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
      
      public function loadCompleted(analyzer:VoteInfoAnalyzer) : void
      {
         loadOver = true;
         list = analyzer.list;
         voteId = analyzer.voteId;
         firstQuestionID = analyzer.firstQuestionID;
         completeMessage = analyzer.completeMessage;
         minGrade = analyzer.minGrade;
         maxGrade = analyzer.maxGrade;
         questionLength = analyzer.questionLength;
         awardDic = analyzer.awardDic;
         dispatchEvent(new Event(LOAD_COMPLETED));
      }
      
      public function openVote() : void
      {
         var id:* = null;
         if(PlayerManager.Instance.Self.Grade < minGrade || PlayerManager.Instance.Self.Grade > maxGrade)
         {
            return;
         }
         voteView = ComponentFactory.Instance.creatComponentByStylename("vote.VoteView");
         voteView.addEventListener(VoteView.OK_CLICK,__chosed);
         voteView.addEventListener(VoteView.VOTEVIEW_CLOSE,__voteViewCLose);
         if(SharedManager.Instance.voteData["userId"] == PlayerManager.Instance.Self.ID)
         {
            id = SharedManager.Instance.voteData["voteId"];
            if(voteId == id)
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
      
      private function __chosed(e:Event) : void
      {
         answerArr.push(voteView.selectAnswer);
         nextQuetion(nowVoteQuestionInfo.nextQuestionID);
      }
      
      private function nextQuetion(questionID:String) : void
      {
         count = Number(count) + 1;
         if(questionID != "0")
         {
            voteView.visible = false;
            nowVoteQuestionInfo = list[questionID];
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
         var i:int = 0;
         var args:* = null;
         var loader:* = null;
         for(i = 0; i < answerArr.length; )
         {
            args = new URLVariables();
            args["userId"] = PlayerManager.Instance.Self.ID;
            args["voteId"] = voteId;
            args["answerContent"] = answerArr[i];
            args["rnd"] = Math.random();
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("VoteSubmitResult.ashx"),6,args,"POST");
            loader.analyzer = new VoteSubmitResultAnalyzer(getResult);
            LoadResourceManager.Instance.startLoad(loader);
            i++;
         }
      }
      
      private function getResult(analyzer:VoteSubmitResultAnalyzer) : void
      {
         if(isVoteComplete)
         {
            return;
         }
         if(analyzer.result == 1)
         {
            MessageTipManager.getInstance().show(completeMessage);
         }
         else
         {
            MessageTipManager.getInstance().show("投票失败!");
         }
         isVoteComplete = true;
      }
      
      private function __voteViewCLose(e:Event) : void
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
