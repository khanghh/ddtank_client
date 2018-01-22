package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import road7th.comm.PackageIn;
   
   public class DDTMatchView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _watchGameBtn:SimpleBitmapButton;
      
      private var _activityTxt:FilterFrameText;
      
      private var _costMoneyTxt:FilterFrameText;
      
      private var _listPanel:ScrollPanel;
      
      private var _listTeamPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _vBoxTeam:VBox;
      
      private var _cellVec:Vector.<DDTMatchBuyCell>;
      
      private var _cellTeamVec:Vector.<DDTMatchBuyCell>;
      
      private var countryList:Array;
      
      private var moneyList:Array;
      
      public function DDTMatchView()
      {
         super();
         initView();
         addEvent();
         SocketManager.Instance.out.getBuyinfo();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.matchBg");
         addChild(_bg);
         _watchGameBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.match.watchGameBtn");
         addChild(_watchGameBtn);
         _activityTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.activityTxt");
         addChild(_activityTxt);
         _activityTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.activityTime",String(ServerConfigManager.instance.getDDTKingQuizCanJoinBeginTime() + "--" + ServerConfigManager.instance.getDDTKingQuizCanJoinEndTime()));
         _costMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.costMoneyTxt");
         addChild(_costMoneyTxt);
         _costMoneyTxt.htmlText = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.costMoney",ServerConfigManager.instance.getDDTKingQuizPrize());
         _cellVec = new Vector.<DDTMatchBuyCell>();
         _vBox = new VBox();
         _vBox.spacing = 3;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new DDTMatchBuyCell(_loc3_,0);
            _vBox.addChild(_loc1_);
            _cellVec.push(_loc1_);
            _loc3_++;
         }
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.scrollPanel");
         _listPanel.setView(_vBox);
         _listPanel.invalidateViewport();
         addChild(_listPanel);
         _cellTeamVec = new Vector.<DDTMatchBuyCell>();
         _vBoxTeam = new VBox();
         _vBoxTeam.spacing = 3;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = new DDTMatchBuyCell(_loc4_,1);
            _vBoxTeam.addChild(_loc2_);
            _cellTeamVec.push(_loc2_);
            _loc4_++;
         }
         _listTeamPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.scrollPanel");
         _listTeamPanel.setView(_vBoxTeam);
         _listTeamPanel.invalidateViewport();
         PositionUtils.setPos(_listTeamPanel,"ddtmatch.match.scrollPanel.pos");
         addChild(_listTeamPanel);
      }
      
      private function addEvent() : void
      {
         _watchGameBtn.addEventListener("click",_watchGameBtnClickHandler);
         DDTMatchManager.instance.addEventListener("matchInfo",__matchInfoHandler);
      }
      
      protected function __matchInfoHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         countryList = [];
         moneyList = [];
         var _loc2_:PackageIn = param1.pkg;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            countryList.push(_loc2_.readInt());
            moneyList.push(_loc2_.readInt());
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _cellVec[_loc3_].setinfo(countryList[_loc3_],moneyList[_loc3_]);
            _cellTeamVec[_loc3_].setinfo(countryList[_loc3_ + 4],moneyList[_loc3_ + 4]);
            _loc3_++;
         }
      }
      
      private function _watchGameBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = PathManager.solveRequestPath("Record/recording.html");
      }
      
      private function removeEvent() : void
      {
         _watchGameBtn.removeEventListener("click",_watchGameBtnClickHandler);
         DDTMatchManager.instance.removeEventListener("matchInfo",__matchInfoHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_watchGameBtn);
         _watchGameBtn = null;
         ObjectUtils.disposeObject(_activityTxt);
         _activityTxt = null;
         ObjectUtils.disposeObject(_costMoneyTxt);
         _costMoneyTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

import bagAndInfo.cell.BagCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.LanguageMgr;

class ScoreCell extends BagCell
{
    
   
   private var _scoreTxt:FilterFrameText;
   
   function ScoreCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true)
   {
      super(param1,param2,param3);
      _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.scoreCellTxt");
      addChild(_scoreTxt);
   }
   
   public function setScore(param1:int) : void
   {
      _scoreTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.scoreCell",param1);
   }
   
   override public function dispose() : void
   {
      ObjectUtils.disposeObject(_scoreTxt);
      _scoreTxt = null;
      super.dispose();
   }
}
