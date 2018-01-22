package setting.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class KeySetFrame extends BaseAlerFrame
   {
       
      
      private var _list:HBox;
      
      private var _defaultSetPalel:KeyDefaultSetPanel;
      
      private var _currentSet:KeySetItem;
      
      private var _tempSets:Dictionary;
      
      private var numberAccect:Bitmap;
      
      private var _submit:TextButton;
      
      private var _cancel:TextButton;
      
      private var _imageRectString:String;
      
      public function KeySetFrame(){super();}
      
      private function initContent() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onSubmit(param1:MouseEvent) : void{}
      
      private function __onCancel(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function okClick() : void{}
      
      private function onItemClick(param1:ItemEvent) : void{}
      
      private function cancelClick() : void{}
      
      private function __ondefaultSetRemove(param1:Event) : void{}
      
      private function creatCell() : void{}
      
      public function show() : void{}
      
      private function clearItemList(param1:Boolean = false) : void{}
      
      public function close() : void{}
      
      private function onItemSelected(param1:Event) : void{}
      
      override public function dispose() : void{}
      
      public function set imageRectString(param1:String) : void{}
      
      public function get imageRectString() : String{return null;}
   }
}
