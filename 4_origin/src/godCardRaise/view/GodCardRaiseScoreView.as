package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardPointRewardListInfo;
   import road7th.utils.DateUtils;
   
   public class GodCardRaiseScoreView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _msgTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _awards:Sprite;
      
      public function GodCardRaiseScoreView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreView.bg");
         addChild(_bg);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreView.timeTxt");
         _timeTxt.text = getCurrentTimeStr();
         addChild(_timeTxt);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreView.contentTxt");
         _contentTxt.text = LanguageMgr.GetTranslation("godCardRaiseScoreView.contentTxtMsg");
         addChild(_contentTxt);
         _msgTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreView.msgTxt");
         _msgTxt.text = "" + GodCardRaiseManager.Instance.model.score;
         addChild(_msgTxt);
         _awards = new Sprite();
         _scrollPanel = ComponentFactory.Instance.creat("godCardRaiseScoreView.scrollPanel");
         _scrollPanel.setView(_awards);
         addChild(_scrollPanel);
         addAwards();
      }
      
      private function getCurrentTimeStr() : String
      {
         var remainTime:Number = (GodCardRaiseManager.Instance.dataEnd.time - TimeManager.Instance.Now().time) / 1000 + 86400;
         var dateArr:Array = DateUtils.dateTimeRemainArr(remainTime);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",dateArr[0],dateArr[1],dateArr[2]);
      }
      
      private function initEvent() : void
      {
      }
      
      private function addAwards() : void
      {
         var i:int = 0;
         var rewardInfo:* = null;
         var scoreViewItem:* = null;
         var godCardPointRewardList:Vector.<GodCardPointRewardListInfo> = GodCardRaiseManager.Instance.godCardPointRewardList;
         for(i = 0; i < godCardPointRewardList.length; )
         {
            rewardInfo = godCardPointRewardList[i];
            scoreViewItem = new GodCardRaiseScoreViewItem(rewardInfo);
            scoreViewItem.y = i * 65;
            _awards.addChild(scoreViewItem);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function updateAwards() : void
      {
         var i:int = 0;
         var scoreViewItem:* = null;
         if(_awards)
         {
            for(i = 0; i < _awards.numChildren; )
            {
               scoreViewItem = _awards.getChildAt(i) as GodCardRaiseScoreViewItem;
               scoreViewItem.updateView();
               i++;
            }
         }
      }
      
      public function updateTime() : void
      {
         if(_timeTxt)
         {
            _timeTxt.text = getCurrentTimeStr();
         }
      }
      
      public function updateView() : void
      {
         if(_msgTxt)
         {
            _msgTxt.text = "" + GodCardRaiseManager.Instance.model.score;
         }
         updateAwards();
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_awards);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _timeTxt = null;
         _contentTxt = null;
         _msgTxt = null;
         _scrollPanel = null;
         _awards = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
