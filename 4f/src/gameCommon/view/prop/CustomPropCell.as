package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.FightPropEevnt;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import room.RoomManager;
   
   public class CustomPropCell extends PropCell
   {
       
      
      private var _deleteBtn:SimpleBitmapButton;
      
      private var _type:int;
      
      private var _lockIcon:Bitmap;
      
      private var _isLock:Boolean = false;
      
      private var _countTxt:FilterFrameText;
      
      public function CustomPropCell(param1:String, param2:int, param3:int){super(null,null);}
      
      public function set isLock(param1:Boolean) : void{}
      
      override protected function configUI() : void{}
      
      override protected function drawLayer() : void{}
      
      override protected function __mouseOut(param1:MouseEvent) : void{}
      
      override protected function __mouseOver(param1:MouseEvent) : void{}
      
      override protected function addEvent() : void{}
      
      private function __deleteClick(param1:MouseEvent) : void{}
      
      private function deleteContainMouse() : Boolean{return false;}
      
      private function deleteProp() : void{}
      
      private function __clicked(param1:MouseEvent) : void{}
      
      override public function set enabled(param1:Boolean) : void{}
      
      override public function useProp() : void{}
      
      private function resetIsUse() : void{}
      
      override protected function removeEvent() : void{}
      
      override public function set info(param1:PropInfo) : void{}
      
      public function setCount(param1:int) : void{}
      
      override public function setPossiton(param1:int, param2:int) : void{}
      
      override public function dispose() : void{}
      
      override public function get tipDirctions() : String{return null;}
   }
}
