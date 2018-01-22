package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class BubbleItem extends Sprite implements Disposeable
   {
       
      
      private var _typeText:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _stateText:FilterFrameText;
      
      public function BubbleItem()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         _typeText = ComponentFactory.Instance.creatComponentByStylename("toolbar.bubbleTypeTxt");
         _typeText.mouseEnabled = false;
         _infoText = ComponentFactory.Instance.creatComponentByStylename("toolbar.bubbleInfoTxt");
         _infoText.mouseEnabled = false;
         _stateText = ComponentFactory.Instance.creatComponentByStylename("toolbar.bubbleStateTxt");
         _stateText.mouseEnabled = false;
         addChild(_typeText);
         addChild(_infoText);
         addChild(_stateText);
         super.graphics.beginFill(65280,0);
         super.graphics.drawRect(0,_stateText.y,_stateText.x + _stateText.width,_stateText.height);
      }
      
      public function setTextInfo(param1:String, param2:String, param3:String) : void
      {
         _typeText.htmlText = param1;
         _infoText.htmlText = param2;
         _stateText.htmlText = param3;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_typeText);
         ObjectUtils.disposeObject(_infoText);
         ObjectUtils.disposeObject(_stateText);
         _typeText = null;
         _infoText = null;
         _stateText = null;
      }
   }
}
