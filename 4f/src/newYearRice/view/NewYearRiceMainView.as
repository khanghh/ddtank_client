package newYearRice.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.text.TextFormat;   import newYearRice.NewYearRiceManager;   import road7th.comm.PackageIn;      public class NewYearRiceMainView extends Frame   {            public static const DINNER:int = 0;            public static const BANQUET:int = 1;            public static const HAN:int = 2;                   private var _openFrameView:NewYearRiceOpenFrameView;            private var _main:MovieClip;            private var _dinnerSelectedBtn:SelectedButton;            private var _banquetSelectedBtn:SelectedButton;            private var _hanSelectedBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _materialsBg:Bitmap;            private var _rewardBg:Bitmap;            private var _makeBtn:BaseButton;            private var _materialsNum_1:FilterFrameText;            private var _materialsNum_2:FilterFrameText;            private var _materialsNum_3:FilterFrameText;            private var _materialsNum_4:FilterFrameText;            private var _goodItemContainerAll:Sprite;            private var _currentNum:Array;            private var _maxNum:Array;            private var _helpBtn:BaseButton;            private var _helpFrame:Frame;            private var _bgHelp:Scale9CornerImage;            private var _content:MovieClip;            private var _btnOk:TextButton;            private var _selfInfo:SelfInfo;            private var _price:int;            private var _roomType:int;            private var _psTxt:FilterFrameText;            private var _alert1:BaseAlerFrame;            private var _alert:BaseAlerFrame;            private var _materialsArr:Array;            public function NewYearRiceMainView() { super(); }
            private function initView() : void { }
            private function addEvnets() : void { }
            private function removeEvents() : void { }
            private function __yearFoodCook(event:CrazyTankSocketEvent) : void { }
            private function __yearFoodEnter(event:CrazyTankSocketEvent) : void { }
            private function __changeHandler(e:Event) : void { }
            private function updateView($selectIndex:int = 0) : void { }
            private function showDinnerView() : void { }
            private function showBanquetView() : void { }
            private function showHanView() : void { }
            private function __makeBtnHandler(evt:MouseEvent) : void { }
            private function __makeNewYearRice(e:FrameEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function showMaterials() : void { }
            private function updateMaterialsText($currentArr:Array, $maxArr:Array) : void { }
            public function upDatafitCount(id:Array) : Array { return null; }
            private function getMaterialsPrice(id:Array) : Array { return null; }
            private function setTFStyle($txt:FilterFrameText) : void { }
            private function showGoods(idArr:Array) : void { }
            private function __helpBtnHandler(evt:MouseEvent) : void { }
            private function __helpFrameRespose(event:FrameEvent) : void { }
            private function __closeHelpFrame(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}