package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class TaskItemView extends Frame
   {
       
      
      private var _func:Function;
      
      private var _clickID:int;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _light:Scale9CornerImage;
      
      private var _titleField:FilterFrameText;
      
      private var _bmpOK:Bitmap;
      
      public function TaskItemView(param1:Function)
      {
         super();
         _func = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         itemBg = ComponentFactory.Instance.creat("regress.taskItemBG");
         itemBg.setFrame(1);
         addChild(itemBg);
         _light = ComponentFactory.Instance.creatComponentByStylename("regress.taskItemLight");
         addChild(_light);
         _light.visible = false;
         titleField = ComponentFactory.Instance.creat("regress.taskItemTitleNormal");
         addChild(titleField);
         bmpOK = ComponentFactory.Instance.creat("asset.taskMenuItem.textImg.OK");
         bmpOK.visible = false;
         addChild(bmpOK);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__MouseClick);
         addEventListener("mouseOver",__MouseOver);
         addEventListener("mouseOut",__MouseOut);
      }
      
      protected function __MouseOver(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      protected function __MouseOut(param1:MouseEvent) : void
      {
         _light.visible = false;
      }
      
      protected function __MouseClick(param1:MouseEvent) : void
      {
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__MouseClick);
         removeEventListener("mouseOver",__MouseOver);
         removeEventListener("mouseOut",__MouseOut);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeVariable();
      }
      
      private function removeVariable() : void
      {
         clickID = 0;
         if(itemBg)
         {
            itemBg.dispose();
            itemBg = null;
         }
         if(_light)
         {
            _light.dispose();
            _light = null;
         }
         if(titleField)
         {
            titleField.dispose();
            titleField = null;
         }
         if(_func != null)
         {
            _func = null;
         }
         if(bmpOK)
         {
            bmpOK = null;
         }
      }
      
      public function get clickID() : int
      {
         return _clickID;
      }
      
      public function set clickID(param1:int) : void
      {
         _clickID = param1;
      }
      
      public function get itemBg() : ScaleFrameImage
      {
         return _itemBg;
      }
      
      public function set itemBg(param1:ScaleFrameImage) : void
      {
         _itemBg = param1;
      }
      
      public function get titleField() : FilterFrameText
      {
         return _titleField;
      }
      
      public function set titleField(param1:FilterFrameText) : void
      {
         _titleField = param1;
      }
      
      public function get bmpOK() : Bitmap
      {
         return _bmpOK;
      }
      
      public function set bmpOK(param1:Bitmap) : void
      {
         _bmpOK = param1;
      }
   }
}
