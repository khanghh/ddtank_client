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
         var _loc1_:Number = (GodCardRaiseManager.Instance.dataEnd.time - TimeManager.Instance.Now().time) / 1000 + 86400;
         var _loc2_:Array = DateUtils.dateTimeRemainArr(_loc1_);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",_loc2_[0],_loc2_[1],_loc2_[2]);
      }
      
      private function initEvent() : void
      {
      }
      
      private function addAwards() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:Vector.<GodCardPointRewardListInfo> = GodCardRaiseManager.Instance.godCardPointRewardList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc3_];
            _loc2_ = new GodCardRaiseScoreViewItem(_loc1_);
            _loc2_.y = _loc3_ * 65;
            _awards.addChild(_loc2_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function updateAwards() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_awards)
         {
            _loc2_ = 0;
            while(_loc2_ < _awards.numChildren)
            {
               _loc1_ = _awards.getChildAt(_loc2_) as GodCardRaiseScoreViewItem;
               _loc1_.updateView();
               _loc2_++;
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
