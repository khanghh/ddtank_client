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
      
      public function set tipData(data:Object) : void
      {
         if(data is String && data != "")
         {
            tip_txt.width = updateW(String(data));
            tip_txt.text = String(data);
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
         _tempData = data;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function init() : void
      {
         addChild(tip_txt);
      }
      
      private function updateW(data:String) : int
      {
         var txt:TextField = new TextField();
         txt.autoSize = "left";
         txt.text = data;
         if(txt.width < _minW)
         {
            return _minW;
         }
         return int(txt.width + 8);
      }
   }
}
