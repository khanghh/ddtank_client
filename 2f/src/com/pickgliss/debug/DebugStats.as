package com.pickgliss.debug
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class DebugStats extends Sprite
   {
      
      private static const _WIDTH:Number = 125;
      
      private static const _MAX_HEIGHT:Number = 75;
      
      private static const _MIN_HEIGHT:Number = 41;
      
      private static const _UPPER_Y:Number = -1;
      
      private static const _LOWER_Y:Number = 9;
      
      private static const _POLY_COL:uint = 16763904;
      
      private static const _MEM_COL:uint = 16711884;
      
      private static var _INSTANCE:DebugStats;
       
      
      private var _timer:Timer;
      
      private var _last_frame_timestamp:Number;
      
      private var _fps:uint;
      
      private var _ram:Number;
      
      private var _max_ram:Number;
      
      private var _min_fps:uint;
      
      private var _avg_fps:Number;
      
      private var _max_fps:uint;
      
      private var _tfaces:uint;
      
      private var _rfaces:uint;
      
      private var _num_frames:uint;
      
      private var _fps_sum:uint;
      
      private var _top_bar:Sprite;
      
      private var _btm_bar:Sprite;
      
      private var _btm_bar_hit:Sprite;
      
      private var _data_format:TextFormat;
      
      private var _label_format:TextFormat;
      
      private var _fps_bar:Shape;
      
      private var _afps_bar:Shape;
      
      private var _lfps_bar:Shape;
      
      private var _hfps_bar:Shape;
      
      private var _diagram:Sprite;
      
      private var _dia_bmp:BitmapData;
      
      private var _mem_points:Array;
      
      private var _mem_graph:Shape;
      
      private var _updates:int;
      
      private var _min_max_btn:Sprite;
      
      private var _fps_tf:TextField;
      
      private var _afps_tf:TextField;
      
      private var _ram_tf:TextField;
      
      private var _poly_tf:TextField;
      
      private var _drag_dx:Number;
      
      private var _drag_dy:Number;
      
      private var _dragging:Boolean;
      
      private var _mean_data:Array;
      
      private var _mean_data_length:int;
      
      private var _enable_reset:Boolean;
      
      private var _enable_mod_fr:Boolean;
      
      private var _transparent:Boolean;
      
      private var _minimized:Boolean;
      
      public function DebugStats(param1:Boolean = false, param2:Boolean = false, param3:uint = 0, param4:Boolean = true, param5:Boolean = true){super();}
      
      public static function get instance() : DebugStats{return null;}
      
      public function get fps() : int{return 0;}
      
      private function _init() : void{}
      
      private function _initMisc() : void{}
      
      private function _initTopBar() : void{}
      
      private function _initBottomBar() : void{}
      
      private function _initDiagrams() : void{}
      
      private function _initInteraction() : void{}
      
      private function _redrawWindow() : void{}
      
      private function _redrawStats() : void{}
      
      private function _redrawMemGraph() : void{}
      
      private function _getRamString(param1:Number) : String{return null;}
      
      private function _reset() : void{}
      
      private function _endDrag() : void{}
      
      private function _onAddedToStage(param1:Event) : void{}
      
      private function _onRemovedFromStage(param1:Event) : void{}
      
      private function _onTimer(param1:Event) : void{}
      
      private function _onEnterFrame(param1:Event) : void{}
      
      private function _onDiagramClick(param1:MouseEvent) : void{}
      
      private function _onAverageFpsClick_reset(param1:MouseEvent) : void{}
      
      private function _onCountersClick_reset(param1:MouseEvent) : void{}
      
      private function _onMinMaxBtnClick(param1:MouseEvent) : void{}
      
      private function _onTopBarMouseDown(param1:MouseEvent) : void{}
      
      private function _onMouseMove(param1:MouseEvent) : void{}
      
      private function _onMouseUpOrLeave(param1:Event) : void{}
   }
}
