package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ChatFaceTip extends Sprite implements Disposeable, ITip
   {
       
      
      private var _minW:int;
      
      private var _minH:int;
      
      private var tip_txt:FilterFrameText;
      
      private var _tempData:Object;
      
      public function ChatFaceTip()
      {
         super();
         tip_txt = ComponentFactory.Instance.creat("core.ChatFaceTxt");
         tip_txt.border = true;
         tip_txt.background = true;
         tip_txt.backgroundColor = 16777215;
         tip_txt.borderColor = 3355443;
         tip_txt.mouseEnabled = false;
         _minW = tip_txt.width;
         this.mouseChildren = false;
         init();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(tip_txt);
         tip_txt = null;
         ObjectUtils.disposeObject(this);
      }
      
      public function get tipData() : Object
      {
         return _tempData;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(param1 is String && param1 != "")
         {
            tip_txt.width = updateW(String(param1));
            tip_txt.text = String(param1);
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
         _tempData = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function init() : void
      {
         addChild(tip_txt);
      }
      
      private function updateW(param1:String) : int
      {
         var _loc2_:TextField = new TextField();
         _loc2_.autoSize = "left";
         _loc2_.text = param1;
         if(_loc2_.width < _minW)
         {
            return _minW;
         }
         return int(_loc2_.width + 8);
      }
   }
}
