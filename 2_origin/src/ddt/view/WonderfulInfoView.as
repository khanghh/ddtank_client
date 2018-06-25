package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WonderfulInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _title:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _okBtn:SimpleBitmapButton;
      
      public function WonderfulInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("hall.wonderfulActivity.infoView");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.closeBtn");
         addChild(_closeBtn);
         _title = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.titleTxt");
         PositionUtils.setPos(_title,"hall.wonderful.infoView.titlePos");
         addChild(_title);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.descTxt");
         PositionUtils.setPos(_infoText,"hall.wonderful.infoView.infoTextPos");
         addChild(_infoText);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("hall.wonderfulActivity.okBtn");
         addChild(_okBtn);
      }
      
      public function show(npcIndex:int, titleTxt:String, contentTxt:String) : void
      {
         _bg.npc.gotoAndStop(npcIndex);
         _title.text = titleTxt;
         _infoText.text = contentTxt;
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__onCloseClickHandler);
         _okBtn.addEventListener("click",__onCloseClickHandler);
      }
      
      protected function __onCloseClickHandler(event:MouseEvent) : void
      {
         dispose();
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__onCloseClickHandler);
         _okBtn.removeEventListener("click",__onCloseClickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
