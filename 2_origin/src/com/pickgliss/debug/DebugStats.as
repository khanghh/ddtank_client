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
      
      public function DebugStats(minimized:Boolean = false, transparent:Boolean = false, meanDataLength:uint = 0, enableClickToReset:Boolean = true, enableModifyFrameRate:Boolean = true)
      {
         super();
         _minimized = minimized;
         _transparent = transparent;
         _enable_reset = enableClickToReset;
         _enable_mod_fr = enableModifyFrameRate;
         _mean_data_length = meanDataLength;
         if(_INSTANCE)
         {
            trace("Creating several statistics windows in one project. Is this intentional?");
         }
         _INSTANCE = this;
         _fps = 0;
         _num_frames = 0;
         _avg_fps = 0;
         _ram = 0;
         _max_ram = 0;
         _tfaces = 0;
         _rfaces = 0;
         _init();
      }
      
      public static function get instance() : DebugStats
      {
         return _INSTANCE;
      }
      
      public function get fps() : int
      {
         return _fps;
      }
      
      private function _init() : void
      {
         _initMisc();
         _initTopBar();
         _initBottomBar();
         _initDiagrams();
         _initInteraction();
         _reset();
         _redrawWindow();
         addEventListener("addedToStage",_onAddedToStage);
         addEventListener("removedFromStage",_onRemovedFromStage);
      }
      
      private function _initMisc() : void
      {
         var i:int = 0;
         _timer = new Timer(200,0);
         _timer.addEventListener("timer",_onTimer);
         _label_format = new TextFormat("_sans",9,16777215,true);
         _data_format = new TextFormat("_sans",9,16777215,false);
         if(_mean_data_length > 0)
         {
            _mean_data = [];
            for(i = 0; i < _mean_data_length; )
            {
               _mean_data[i] = 0;
               i++;
            }
         }
      }
      
      private function _initTopBar() : void
      {
         var logo:* = null;
         var markers:* = null;
         var fps_label_tf:* = null;
         var afps_label_tf:* = null;
         _top_bar = new Sprite();
         _top_bar.graphics.beginFill(0,0);
         _top_bar.graphics.drawRect(0,0,125,20);
         addChild(_top_bar);
         logo = new Shape();
         logo.x = 9;
         logo.y = 7.5;
         logo.scaleX = 0.6;
         logo.scaleY = 0.6;
         logo.graphics.beginFill(16777215,1);
         logo.graphics.moveTo(-0.5,-7);
         logo.graphics.curveTo(-0.5,-7.7,-1,-7);
         logo.graphics.lineTo(-9,5);
         logo.graphics.curveTo(-9.3,5.5,-8,5);
         logo.graphics.curveTo(-1,1,-0.5,-7);
         logo.graphics.moveTo(0.5,-7);
         logo.graphics.curveTo(0.5,-7.7,1,-7);
         logo.graphics.lineTo(9,5);
         logo.graphics.curveTo(9.3,5.5,8,5);
         logo.graphics.curveTo(1,1,0.5,-7);
         logo.graphics.moveTo(-8,7);
         logo.graphics.curveTo(-8.3,6.7,-7.5,6.3);
         logo.graphics.curveTo(0,2,7.5,6.3);
         logo.graphics.curveTo(8.3,6.7,8,7);
         logo.graphics.lineTo(-8,7);
         _top_bar.addChild(logo);
         markers = new Shape();
         markers.graphics.beginFill(16777215);
         markers.graphics.drawRect(20,7,4,4);
         markers.graphics.beginFill(3377373);
         markers.graphics.drawRect(77,7,4,4);
         _top_bar.addChild(markers);
         fps_label_tf = new TextField();
         fps_label_tf.defaultTextFormat = _label_format;
         fps_label_tf.autoSize = "left";
         fps_label_tf.text = "FR:";
         fps_label_tf.x = 24;
         fps_label_tf.y = 2;
         fps_label_tf.selectable = false;
         _top_bar.addChild(fps_label_tf);
         _fps_tf = new TextField();
         _fps_tf.defaultTextFormat = _data_format;
         _fps_tf.autoSize = "left";
         _fps_tf.x = fps_label_tf.x + 16;
         _fps_tf.y = fps_label_tf.y;
         _fps_tf.selectable = false;
         _top_bar.addChild(_fps_tf);
         afps_label_tf = new TextField();
         afps_label_tf.defaultTextFormat = _label_format;
         afps_label_tf.autoSize = "left";
         afps_label_tf.text = "A:";
         afps_label_tf.x = 81;
         afps_label_tf.y = 2;
         afps_label_tf.selectable = false;
         _top_bar.addChild(afps_label_tf);
         _afps_tf = new TextField();
         _afps_tf.defaultTextFormat = _data_format;
         _afps_tf.autoSize = "left";
         _afps_tf.x = afps_label_tf.x + 12;
         _afps_tf.y = afps_label_tf.y;
         _afps_tf.selectable = false;
         _top_bar.addChild(_afps_tf);
         _min_max_btn = new Sprite();
         _min_max_btn.x = 125 - 8;
         _min_max_btn.y = 7;
         _min_max_btn.graphics.beginFill(0,0);
         _min_max_btn.graphics.lineStyle(1,15724527,1,true);
         _min_max_btn.graphics.drawRect(-4,-4,8,8);
         _min_max_btn.graphics.moveTo(-3,2);
         _min_max_btn.graphics.lineTo(3,2);
         _min_max_btn.buttonMode = true;
         _min_max_btn.addEventListener("click",_onMinMaxBtnClick);
         _top_bar.addChild(_min_max_btn);
      }
      
      private function _initBottomBar() : void
      {
         var markers:* = null;
         var ram_label_tf:* = null;
         var poly_label_tf:* = null;
         _btm_bar = new Sprite();
         _btm_bar.graphics.beginFill(0,0.2);
         _btm_bar.graphics.drawRect(0,0,125,21);
         addChild(_btm_bar);
         _btm_bar_hit = new Sprite();
         _btm_bar_hit.graphics.beginFill(16763904,0);
         _btm_bar_hit.graphics.drawRect(0,1,125,20);
         addChild(_btm_bar_hit);
         markers = new Shape();
         markers.graphics.beginFill(16711884);
         markers.graphics.drawRect(5,4,4,4);
         markers.graphics.beginFill(16763904);
         markers.graphics.drawRect(5,14,4,4);
         _btm_bar.addChild(markers);
         ram_label_tf = new TextField();
         ram_label_tf.defaultTextFormat = _label_format;
         ram_label_tf.autoSize = "left";
         ram_label_tf.text = "RAM:";
         ram_label_tf.x = 10;
         ram_label_tf.y = -1;
         ram_label_tf.selectable = false;
         ram_label_tf.mouseEnabled = false;
         _btm_bar.addChild(ram_label_tf);
         _ram_tf = new TextField();
         _ram_tf.defaultTextFormat = _data_format;
         _ram_tf.autoSize = "left";
         _ram_tf.x = ram_label_tf.x + 31;
         _ram_tf.y = ram_label_tf.y;
         _ram_tf.selectable = false;
         _ram_tf.mouseEnabled = false;
         _btm_bar.addChild(_ram_tf);
         poly_label_tf = new TextField();
         poly_label_tf.defaultTextFormat = _label_format;
         poly_label_tf.autoSize = "left";
         poly_label_tf.text = "POLY:";
         poly_label_tf.x = 10;
         poly_label_tf.y = 9;
         poly_label_tf.selectable = false;
         poly_label_tf.mouseEnabled = false;
         _btm_bar.addChild(poly_label_tf);
         _poly_tf = new TextField();
         _poly_tf.defaultTextFormat = _data_format;
         _poly_tf.autoSize = "left";
         _poly_tf.x = poly_label_tf.x + 31;
         _poly_tf.y = poly_label_tf.y;
         _poly_tf.selectable = false;
         _poly_tf.mouseEnabled = false;
         _btm_bar.addChild(_poly_tf);
      }
      
      private function _initDiagrams() : void
      {
         _dia_bmp = new BitmapData(125,75 - 40,true,0);
         _diagram = new Sprite();
         _diagram.graphics.beginBitmapFill(_dia_bmp);
         _diagram.graphics.drawRect(0,0,_dia_bmp.width,_dia_bmp.height);
         _diagram.graphics.endFill();
         _diagram.y = 17;
         addChild(_diagram);
         _diagram.graphics.lineStyle(1,16777215,0.03);
         _diagram.graphics.moveTo(0,0);
         _diagram.graphics.lineTo(125,0);
         _diagram.graphics.moveTo(0,Math.floor(_dia_bmp.height / 2));
         _diagram.graphics.lineTo(125,Math.floor(_dia_bmp.height / 2));
         _fps_bar = new Shape();
         _fps_bar.graphics.beginFill(16777215);
         _fps_bar.graphics.drawRect(0,0,125,4);
         _fps_bar.x = 0;
         _fps_bar.y = 16;
         addChild(_fps_bar);
         _afps_bar = new Shape();
         _afps_bar.graphics.lineStyle(1,3377373,1,false,"normal","square");
         _afps_bar.graphics.lineTo(0,4);
         _afps_bar.y = _fps_bar.y;
         addChild(_afps_bar);
         _lfps_bar = new Shape();
         _lfps_bar.graphics.lineStyle(1,16711680,1,false,"normal","square");
         _lfps_bar.graphics.lineTo(0,4);
         _lfps_bar.y = _fps_bar.y;
         addChild(_lfps_bar);
         _hfps_bar = new Shape();
         _hfps_bar.graphics.lineStyle(1,65280,1,false,"normal","square");
         _hfps_bar.graphics.lineTo(0,4);
         _hfps_bar.y = _fps_bar.y;
         addChild(_hfps_bar);
         _mem_points = [];
         _mem_graph = new Shape();
         _mem_graph.y = _diagram.y + _diagram.height;
         addChildAt(_mem_graph,0);
      }
      
      private function _initInteraction() : void
      {
         _top_bar.addEventListener("mouseDown",_onTopBarMouseDown);
         if(_enable_reset)
         {
            _btm_bar.mouseEnabled = false;
            _btm_bar_hit.addEventListener("click",_onCountersClick_reset);
            _afps_tf.addEventListener("mouseUp",_onAverageFpsClick_reset,false,1);
         }
         if(_enable_mod_fr)
         {
            _diagram.addEventListener("click",_onDiagramClick);
         }
      }
      
      private function _redrawWindow() : void
      {
         var plate_height:Number = NaN;
         plate_height = !!_minimized?41:75;
         if(!_transparent)
         {
            this.graphics.clear();
            this.graphics.beginFill(0,0.6);
            this.graphics.drawRect(0,0,125,plate_height);
         }
         _min_max_btn.rotation = !!_minimized?180:0;
         _btm_bar.y = plate_height - 21;
         _btm_bar_hit.y = _btm_bar.y;
         _diagram.visible = !_minimized;
         _mem_graph.visible = !_minimized;
         _fps_bar.visible = _minimized;
         _afps_bar.visible = _minimized;
         _lfps_bar.visible = _minimized;
         _hfps_bar.visible = _minimized;
         if(!_minimized)
         {
            _redrawMemGraph();
         }
      }
      
      private function _redrawStats() : void
      {
         var dia_y:int = 0;
         _fps_tf.text = _fps.toString().concat("/",stage.frameRate);
         _afps_tf.text = Math.round(_avg_fps).toString();
         _ram_tf.text = _getRamString(_ram).concat(" / ",_getRamString(_max_ram));
         _dia_bmp.scroll(1,0);
         _poly_tf.text = "n/a (no view)";
         dia_y = _dia_bmp.height - Math.floor(_fps / stage.frameRate * _dia_bmp.height);
         _dia_bmp.setPixel32(1,dia_y,4294967295);
         dia_y = _dia_bmp.height - Math.floor(_avg_fps / stage.frameRate * _dia_bmp.height);
         _dia_bmp.setPixel32(1,dia_y,4281580543);
         if(_minimized)
         {
            _fps_bar.scaleX = Math.min(1,_fps / stage.frameRate);
            _afps_bar.x = Math.min(1,_avg_fps / stage.frameRate) * 125;
            _lfps_bar.x = Math.min(1,_min_fps / stage.frameRate) * 125;
            _hfps_bar.x = Math.min(1,_max_fps / stage.frameRate) * 125;
         }
         else if(_updates % 5 == 0)
         {
            _redrawMemGraph();
         }
         _mem_graph.x = _updates % 5;
         _updates = Number(_updates) + 1;
      }
      
      private function _redrawMemGraph() : void
      {
         var i:int = 0;
         var g:* = null;
         var max_val:* = 0;
         _mem_graph.scaleY = 1;
         g = _mem_graph.graphics;
         g.clear();
         g.lineStyle(0.5,16711884,1,true,"none");
         g.moveTo(5 * (_mem_points.length - 1),-_mem_points[_mem_points.length - 1]);
         for(i = _mem_points.length - 1; i >= 0; )
         {
            if(_mem_points[i + 1] == 0 || _mem_points[i] == 0)
            {
               g.moveTo(i * 5,-_mem_points[i]);
            }
            else
            {
               g.lineTo(i * 5,-_mem_points[i]);
               if(_mem_points[i] > max_val)
               {
                  max_val = Number(_mem_points[i]);
               }
            }
            i--;
         }
         _mem_graph.scaleY = _dia_bmp.height / max_val;
      }
      
      private function _getRamString(ram:Number) : String
      {
         var ram_unit:String = "B";
         if(ram > 1048576)
         {
            ram = ram / 1048576;
            ram_unit = "M";
         }
         else if(ram > 1024)
         {
            ram = ram / 1024;
            ram_unit = "K";
         }
         return ram.toFixed(1) + ram_unit;
      }
      
      private function _reset() : void
      {
         var i:int = 0;
         _updates = 0;
         _num_frames = 0;
         _min_fps = 2147483647;
         _max_fps = 0;
         _avg_fps = 0;
         _fps_sum = 0;
         _max_ram = 0;
         for(i = 0; i < 125 / 5; )
         {
            _mem_points[i] = 0;
            i++;
         }
         if(_mean_data)
         {
            for(i = 0; i < _mean_data.length; )
            {
               _mean_data[i] = 0;
               i++;
            }
         }
         _mem_graph.graphics.clear();
         _dia_bmp.fillRect(_dia_bmp.rect,0);
      }
      
      private function _endDrag() : void
      {
         if(this.x < -125)
         {
            this.x = -105;
         }
         else if(this.x > stage.stageWidth)
         {
            this.x = stage.stageWidth - 20;
         }
         if(this.y < 0)
         {
            this.y = 0;
         }
         else if(this.y > stage.stageHeight)
         {
            this.y = stage.stageHeight - 15;
         }
         this.x = Math.round(this.x);
         this.y = Math.round(this.y);
         _dragging = false;
         stage.removeEventListener("mouseLeave",_onMouseUpOrLeave);
         stage.removeEventListener("mouseUp",_onMouseUpOrLeave);
         stage.removeEventListener("mouseMove",_onMouseMove);
      }
      
      private function _onAddedToStage(ev:Event) : void
      {
         _timer.start();
         addEventListener("enterFrame",_onEnterFrame);
      }
      
      private function _onRemovedFromStage(ev:Event) : void
      {
         _timer.stop();
         removeEventListener("enterFrame",_onTimer);
      }
      
      private function _onTimer(ev:Event) : void
      {
         _ram = System.totalMemory;
         if(_ram > _max_ram)
         {
            _max_ram = _ram;
         }
         if(_updates % 5 == 0)
         {
            _mem_points.unshift(_ram / 1024);
            _mem_points.pop();
         }
         _redrawStats();
      }
      
      private function _onEnterFrame(ev:Event) : void
      {
         var time:Number = getTimer() - _last_frame_timestamp;
         _fps = Math.floor(1000 / time);
         _fps_sum = _fps_sum + _fps;
         if(_fps > _max_fps)
         {
            _max_fps = _fps;
         }
         else if(_fps != 0 && _fps < _min_fps)
         {
            _min_fps = _fps;
         }
         if(_mean_data)
         {
            _mean_data.push(_fps);
            _fps_sum = _fps_sum - _mean_data.shift();
            _avg_fps = _fps_sum / _mean_data_length;
         }
         else
         {
            _num_frames = Number(_num_frames) + 1;
            _avg_fps = _fps_sum / _num_frames;
         }
         _last_frame_timestamp = getTimer();
      }
      
      private function _onDiagramClick(ev:MouseEvent) : void
      {
         stage.frameRate = stage.frameRate - Math.floor((_diagram.mouseY - _dia_bmp.height / 2) / 5);
      }
      
      private function _onAverageFpsClick_reset(ev:MouseEvent) : void
      {
         var i:int = 0;
         if(!_dragging)
         {
            _num_frames = 0;
            _fps_sum = 0;
            if(_mean_data)
            {
               for(i = 0; i < _mean_data.length; )
               {
                  _mean_data[i] = 0;
                  i++;
               }
            }
         }
      }
      
      private function _onCountersClick_reset(ev:MouseEvent) : void
      {
         _reset();
      }
      
      private function _onMinMaxBtnClick(ev:MouseEvent) : void
      {
         _minimized = !_minimized;
         _redrawWindow();
      }
      
      private function _onTopBarMouseDown(ev:MouseEvent) : void
      {
         _drag_dx = this.mouseX;
         _drag_dy = this.mouseY;
         stage.addEventListener("mouseMove",_onMouseMove);
         stage.addEventListener("mouseUp",_onMouseUpOrLeave);
         stage.addEventListener("mouseLeave",_onMouseUpOrLeave);
      }
      
      private function _onMouseMove(ev:MouseEvent) : void
      {
         _dragging = true;
         this.x = stage.mouseX - _drag_dx;
         this.y = stage.mouseY - _drag_dy;
      }
      
      private function _onMouseUpOrLeave(ev:Event) : void
      {
         _endDrag();
      }
   }
}
