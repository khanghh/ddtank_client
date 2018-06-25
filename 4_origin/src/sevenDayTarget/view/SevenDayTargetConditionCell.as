package sevenDayTarget.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import sevenDayTarget.controller.NewSevenDayAndNewPlayerManager;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class SevenDayTargetConditionCell extends Sprite
   {
       
      
      private var _todayQuestInfo:NewTargetQuestionInfo;
      
      private var conditionText:FilterFrameText;
      
      private var conditionUnComplete:Bitmap;
      
      private var conditionComplete:Bitmap;
      
      private var linkText:FilterFrameText;
      
      private var linkSp:Sprite;
      
      public function SevenDayTargetConditionCell(info:NewTargetQuestionInfo)
      {
         super();
         _todayQuestInfo = info;
      }
      
      public function setView(discripe:String, completed:Boolean, canClick:Boolean = true) : void
      {
         conditionText = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.view.conditionText");
         conditionText.text = discripe;
         if(conditionText.text.length > 10)
         {
            PositionUtils.setPos(conditionText,"sevenDayTarget.view.conditiontextPos1");
         }
         else
         {
            PositionUtils.setPos(conditionText,"sevenDayTarget.view.conditiontextPos2");
         }
         addChild(conditionText);
         linkSp = new Sprite();
         linkSp.graphics.beginFill(65280,0);
         if(canClick)
         {
            linkSp.addEventListener("click",__clickLinkText);
            linkSp.buttonMode = true;
            linkText = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.view.linktxt");
         }
         else
         {
            linkText = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.view.linktxt2");
         }
         linkText.text = LanguageMgr.GetTranslation("sevenDayTarget.view.link");
         linkSp.graphics.drawRect(0,0,linkText.width,linkText.height);
         linkSp.graphics.endFill();
         PositionUtils.setPos(linkSp,"sevenDayTarget.view.linkPos1");
         PositionUtils.setPos(linkText,"sevenDayTarget.view.linkPos1");
         addChild(linkText);
         addChild(linkSp);
         conditionComplete = ComponentFactory.Instance.creat("sevenDayTarget.finish");
         PositionUtils.setPos(conditionComplete,"sevenDayTarget.view.finishPos");
         addChild(conditionComplete);
         conditionUnComplete = ComponentFactory.Instance.creat("sevenDayTarget.unfinish");
         PositionUtils.setPos(conditionUnComplete,"sevenDayTarget.view.finishPos");
         addChild(conditionUnComplete);
         if(completed)
         {
            conditionComplete.visible = true;
            conditionUnComplete.visible = false;
         }
         else
         {
            conditionComplete.visible = false;
            conditionUnComplete.visible = true;
         }
      }
      
      public function dispose() : void
      {
         if(linkSp)
         {
            linkSp.removeEventListener("click",__clickLinkText);
         }
         if(conditionText)
         {
            conditionText.dispose();
            conditionText = null;
         }
         if(conditionUnComplete)
         {
            conditionUnComplete.bitmapData.dispose();
            conditionUnComplete = null;
         }
         if(linkText)
         {
            linkText.dispose();
            linkText = null;
         }
         if(conditionComplete)
         {
            conditionComplete.bitmapData.dispose();
            conditionComplete = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function __clickLinkText(e:MouseEvent) : void
      {
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("clickLink"));
      }
   }
}
