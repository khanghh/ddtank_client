package magicHouse.magicBox
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseFusionView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemsContentBg:Bitmap;
      
      private var _fusionCellContentBg:Bitmap;
      
      private var _materialContentBg:Bitmap;
      
      private var _selfMoney:FilterFrameText;
      
      private var _selfElite:FilterFrameText;
      
      private var _itemCounts:FilterFrameText;
      
      private var _inputNumBg:Bitmap;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _curNum:int;
      
      private var _maxNum:int;
      
      private var _needElite:FilterFrameText;
      
      private var _eliteCounts:FilterFrameText;
      
      private var _needMoney:FilterFrameText;
      
      private var _moneyCounts:FilterFrameText;
      
      private var _fusionCheckBtn:SelectedCheckButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _fusionBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _itemContents:VBox;
      
      private var _itemPanel:ScrollPanel;
      
      private var _itemInfoArr:Array;
      
      private var _itemArr:Array;
      
      private var _currentItem:MagicBoxFusionItem;
      
      private var _currentItemCell:BagCell;
      
      private var _materialArr:Array;
      
      private var _materialCountTxt1:FilterFrameText;
      
      private var _materialCountTxt2:FilterFrameText;
      
      private var _materialCountTxt3:FilterFrameText;
      
      private var _materialCountTxt4:FilterFrameText;
      
      private var _propBag:BagInfo;
      
      private var _isComposeEnable:Boolean = false;
      
      private var _fusionMc:MovieClip;
      
      private var _mashArea:MagicBoxMashArea;
      
      public function MagicHouseFusionView(){super();}
      
      private function initView() : void{}
      
      private function __itemClickHandler(param1:MouseEvent) : void{}
      
      private function _changeRightView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __messageUpdate(param1:Event) : void{}
      
      private function __fusionComplete(param1:Event) : void{}
      
      private function __fusionMcComplete(param1:Event) : void{}
      
      private function __mashAreaClickHandler(param1:MouseEvent) : void{}
      
      private function __fusionClickHandler(param1:MouseEvent) : void{}
      
      private function _canFusion() : Boolean{return false;}
      
      private function __fusionCheckHandler(param1:Event) : void{}
      
      private function __maxHandler(param1:MouseEvent) : void{}
      
      private function __inputTextChangeHandler(param1:Event) : void{}
      
      private function __helpClick(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      private function __updateBag(param1:BagEvent) : void{}
      
      public function dispose() : void{}
   }
}
