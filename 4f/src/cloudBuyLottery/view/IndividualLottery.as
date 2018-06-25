package cloudBuyLottery.view{   import bagAndInfo.cell.BaseCell;   import cloudBuyLottery.CloudBuyLotteryManager;   import com.greensock.TweenMax;   import com.greensock.easing.Elastic;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.setTimeout;      public class IndividualLottery extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _bg2:Bitmap;            private var _jubaoMC:MovieClip;            private var _helpTxt:FilterFrameText;            private var _juBaoBtn:BaseButton;            private var _numTxt:FilterFrameText;            private var _num:FilterFrameText;            private var _selectSprite:Sprite;            private var _selectedCell:BaseCell;            private var itemInfo:ItemTemplateInfo;            private var tInfo:InventoryItemInfo;            private var flag:Boolean = false;            private var gotoFlag:Boolean = true;            private var _look:BaseButton;            private var _lookGoods:LookGoodsFrame;            private var _paopao:Bitmap;            public function IndividualLottery() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __updateInfo(e:Event) : void { }
            private function updateData(id:int) : void { }
            private function __lookGoods(evt:MouseEvent) : void { }
            private function __onClick(evt:MouseEvent) : void { }
            private function __onEnterFrame(evt:Event) : void { }
            private function btnIsClick(flag:Boolean) : void { }
            private function creatTweenMagnify(duration:Number = 1, scale:Number = 1.5, repeat:int = -1, yoyo:Boolean = true, delay:int = 1100) : void { }
            private function _timeOut() : void { }
            private function _clear() : void { }
            private function showJuBaoBtn() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}