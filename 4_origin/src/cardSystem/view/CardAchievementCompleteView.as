package cardSystem.view
{
   import cardSystem.CardManager;
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class CardAchievementCompleteView extends Sprite implements Disposeable
   {
       
      
      private var _commitBtnTxt:FilterFrameText;
      
      private var _timeOutId:int;
      
      private var _info:CardAchievementInfo;
      
      public function CardAchievementCompleteView(param1:*)
      {
         super();
         _info = param1;
         _timeOutId = setTimeout(dispose,5500);
         initView();
         this.addEventListener("addedToStage",onATS);
      }
      
      public function show() : void
      {
         this.x = 363;
         this.y = 431;
         LayerManager.Instance.addToLayer(this,1);
      }
      
      protected function onATS(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onATS);
         SoundManager.instance.play("215");
      }
      
      private function initView() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.hall.taskComplete.commitView.bg");
         _loc1_.gotoAndStop(2);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.contentTxt");
         _loc2_.text = LanguageMgr.GetTranslation("tank.card.achievement.complete",_info.Name);
         _commitBtnTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.commitBtnTxt");
         _commitBtnTxt.htmlText = "<u><a href=\"event:1\">" + LanguageMgr.GetTranslation("tank.card.achievement.look") + "</a></u>";
         _commitBtnTxt.addEventListener("link",textClickHandler);
         _commitBtnTxt.mouseEnabled = true;
         _commitBtnTxt.selectable = false;
         addChild(_loc1_);
         addChild(_loc2_);
         addChild(_commitBtnTxt);
      }
      
      private function textClickHandler(param1:TextEvent) : void
      {
         SoundManager.instance.playButtonSound();
         CardManager.Instance.showView(2);
         dispose();
      }
      
      public function dispose() : void
      {
         clearTimeout(_timeOutId);
         if(_commitBtnTxt)
         {
            _commitBtnTxt.removeEventListener("link",textClickHandler);
         }
         ObjectUtils.disposeAllChildren(this);
         _commitBtnTxt = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
