package farm.viewx
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   import petsBag.PetsBagManager;
   
   public class FarmFieldBlock extends Sprite implements Disposeable, IAcceptDrag
   {
       
      
      private var _fieldId:int;
      
      private var _info:FieldVO;
      
      private var _picPath:String;
      
      private var _field:ScaleFrameImage;
      
      private var _flag:SimpleBitmapButton;
      
      private var _hitArea:Sprite;
      
      private var _loadingasset:MovieClip;
      
      private var _loader:DisplayLoader;
      
      private var _type:int = -1;
      
      private var _plant:BaseButton;
      
      private var _countdown:CountdownView;
      
      public function FarmFieldBlock(param1:int){super();}
      
      public function set flag(param1:Boolean) : void{}
      
      public function get info() : FieldVO{return null;}
      
      public function set info(param1:FieldVO) : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      private function upTips() : void{}
      
      private function initEvent() : void{}
      
      public function setBeginHelper(param1:int) : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      private function __onMouseOut(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      protected function __accelerate(param1:Event) : void{}
      
      protected function __frush(param1:Event) : void{}
      
      private function __plantClickHandler(param1:MouseEvent) : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      private function petFarmGuilde() : void{}
      
      private function loadIcon(param1:int) : void{}
      
      private function __complete(param1:LoaderEvent) : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      private function __flagClickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
