package totem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   import trainer.view.NewHandContainer;
   
   public class TotemLeftWindowView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bgList:Vector.<Bitmap>;
      
      private var _totemPointBgList:Vector.<BitmapData>;
      
      private var _totemPointIconList:Vector.<BitmapData>;
      
      private var _totemPointSprite:Sprite;
      
      private var _totemPointList:Vector.<TotemLeftWindowTotemCell>;
      
      private var _curCanClickPointLocation:int;
      
      private var _totemPointLocationList:Array;
      
      private var _windowBorder:Bitmap;
      
      private var _lineShape:Shape;
      
      private var _lightGlowFilter:GlowFilter;
      
      private var _grayGlowFilter:ColorMatrixFilter;
      
      private var _openCartoonSprite:TotemLeftWindowOpenCartoonView;
      
      private var _propertyTxtSprite:TotemLeftWindowPropertyTxtView;
      
      private var _tipView:TotemPointTipView;
      
      private var _chapterIcon:TotemLeftWindowChapterIcon;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var confirmFrame:BaseAlerFrame;
      
      public function TotemLeftWindowView(){super();}
      
      private function init() : void{}
      
      public function refreshView(param1:TotemDataVo, param2:Function = null) : void{}
      
      public function openFailHandler(param1:TotemDataVo) : void{}
      
      private function enableCurCanClickBtn() : void{}
      
      private function disenableCurCanClickBtn() : void{}
      
      public function show(param1:int, param2:TotemDataVo, param3:Boolean) : void{}
      
      private function addTotemPoint(param1:Array, param2:int, param3:TotemDataVo, param4:Boolean) : void{}
      
      private function refreshGlowFilter(param1:int, param2:TotemDataVo) : void{}
      
      private function refreshTotemPoint(param1:int, param2:TotemDataVo, param3:Boolean) : void{}
      
      public function scalePropertyTxtSprite(param1:Number) : void{}
      
      private function openTotem(param1:MouseEvent) : void{}
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void{}
      
      private function __openOneTotemConfirms(param1:FrameEvent) : void{}
      
      private function __openOneTotemConfirm(param1:FrameEvent) : void{}
      
      private function doOpenOneTotem(param1:Boolean) : void{}
      
      private function showTip(param1:MouseEvent) : void{}
      
      private function hideTip(param1:MouseEvent) : void{}
      
      private function drawTestPoint() : void{}
      
      private function drawLine(param1:int, param2:TotemDataVo, param3:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
