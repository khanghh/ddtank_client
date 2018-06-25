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
         var j:int = 0;
         var buyCell:* = null;
         var i:int = 0;
         var buyCell1:* = null;
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
         for(j = 0; j < 4; )
         {
            buyCell = new DDTMatchBuyCell(j,0);
            _vBox.addChild(buyCell);
            _cellVec.push(buyCell);
            j++;
         }
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.scrollPanel");
         _listPanel.setView(_vBox);
         _listPanel.invalidateViewport();
         addChild(_listPanel);
         _cellTeamVec = new Vector.<DDTMatchBuyCell>();
         _vBoxTeam = new VBox();
         _vBoxTeam.spacing = 3;
         for(i = 0; i < 4; )
         {
            buyCell1 = new DDTMatchBuyCell(i,1);
            _vBoxTeam.addChild(buyCell1);
            _cellTeamVec.push(buyCell1);
            i++;
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
      
      protected function __matchInfoHandler(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         countryList = [];
         moneyList = [];
         var pkg:PackageIn = event.pkg;
         for(i = 0; i < 8; )
         {
            countryList.push(pkg.readInt());
            moneyList.push(pkg.readInt());
            i++;
         }
         for(i = 0; i < 4; )
         {
            _cellVec[i].setinfo(countryList[i],moneyList[i]);
            _cellTeamVec[i].setinfo(countryList[i + 4],moneyList[i + 4]);
            i++;
         }
      }
      
      private function _watchGameBtnClickHandler(e:MouseEvent) : void
      {
         var str:String = PathManager.solveRequestPath("Record/recording.html");
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
   
   function ScoreCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true)
   {
      super(index,info,showLoading);
      _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.scoreCellTxt");
      addChild(_scoreTxt);
   }
   
   public function setScore(score:int) : void
   {
      _scoreTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.scoreCell",score);
   }
   
   override public function dispose() : void
   {
      ObjectUtils.disposeObject(_scoreTxt);
      _scoreTxt = null;
      super.dispose();
   }
}
