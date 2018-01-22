package magicHouse.magicCollection
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicHouse.MagicHouseControl;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseCollectionMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _typeWeaponBtn:SimpleBitmapButton;
      
      private var _freeBtn:SimpleBitmapButton;
      
      private var _goldenBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _promoteMagicAttack:FilterFrameText;
      
      private var _promoteMagicDefense:FilterFrameText;
      
      private var _promoteCritDamage:FilterFrameText;
      
      private var _valueMagicAttack:FilterFrameText;
      
      private var _valueMagicDefense:FilterFrameText;
      
      private var _valueCritDamage:FilterFrameText;
      
      private var _juniorItem:MagicHouseCollectionItemView;
      
      private var _midItem:MagicHouseCollectionItemView;
      
      private var _seniorItem:MagicHouseCollectionItemView;
      
      private var _freeCell:Bitmap;
      
      private var _freeCellBtn:RichesButton;
      
      private var _freeCountTxt:FilterFrameText;
      
      private var _potionCell:BagCell;
      
      public function MagicHouseCollectionMainView(){super();}
      
      private function initView() : void{}
      
      private function setData() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __helpClick(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      private function __messageUpdate(param1:Event) : void{}
      
      private function __freeGet(param1:MouseEvent) : void{}
      
      private function __chargeGet(param1:MouseEvent) : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      public function dispose() : void{}
   }
}
