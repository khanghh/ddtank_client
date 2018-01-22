package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.item.GradientBitmapText;
   import Indiana.item.IndianaShowBuyCodeView;
   import Indiana.item.IndianaTitleCellView;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.character.BaseWingLayer;
   import ddt.view.character.ILayer;
   import ddt.view.character.LayerFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import invite.InviteManager;
   import pet.data.PetInfo;
   import pet.data.PetTemplateInfo;
   import petsBag.view.item.PetBigItem;
   import road.game.resource.ActionMovie;
   import road.game.resource.ActionMovieEvent;
   
   public class IndianaMainView extends Frame
   {
       
      
      private var _frameBg:Bitmap;
      
      private var _iconCon:Sprite;
      
      private var _itemName:GradientBitmapText;
      
      private var _helpBtn:BaseButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _itemDetails:SelectedButton;
      
      private var _itemRecode:SelectedButton;
      
      private var _itemHis:SelectedButton;
      
      private var _leftPageBtn:BaseButton;
      
      private var _rightPageBtn:BaseButton;
      
      private var _titleView:IndianaTitleCellView;
      
      private var _infoLogic:IndianaMainInfoLogic;
      
      private var _detaileView:IndianaDetaileView;
      
      private var _currentView:DisplayObject;
      
      private var _itemDis:GradientBitmapText;
      
      private var _itemValue:FilterFrameText;
      
      private var _itemDisII:FilterFrameText;
      
      private var _recodeView:IndianaRecodePanel;
      
      private var _historyView:HistoryofIndianaPanel;
      
      private var _info:Array;
      
      private var _petMovie:ActionMovie;
      
      private var _petItem:PetBigItem;
      
      private var _wing:MovieClip;
      
      private var _icon:Bitmap;
      
      private var _currentInfo:IndianaShopItemInfo;
      
      private var _buyCodeView:IndianaShowBuyCodeView;
      
      private var _loader:BitmapLoader;
      
      private var ACTIONS:Array;
      
      private var layer:ILayer;
      
      private var _lastTime:uint = 0;
      
      private var isFirst:Boolean = true;
      
      private var _currentPerodId:int;
      
      public function IndianaMainView(){super();}
      
      private function initView() : void{}
      
      private function clearIcon() : void{}
      
      private function setIcon(param1:IndianaShopItemInfo) : void{}
      
      private function setTitleInfo(param1:IndianaShopItemInfo) : void{}
      
      private function __bitmapOnComplete(param1:LoaderEvent) : void{}
      
      private function __wingOnComplete(param1:BaseWingLayer) : void{}
      
      private function __onComplete(param1:LoaderEvent) : void{}
      
      private function doNextAction(param1:ActionMovieEvent) : void{}
      
      public function show() : void{}
      
      public function upData() : void{}
      
      private function initEvent() : void{}
      
      private function __checkCodeHandler(param1:PkgEvent) : void{}
      
      private function __leftClickHandler(param1:MouseEvent) : void{}
      
      private function __rightClickHandler(param1:MouseEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function clearLoader() : void{}
      
      private function removeEvent() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
