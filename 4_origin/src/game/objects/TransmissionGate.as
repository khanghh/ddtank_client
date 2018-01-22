package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Timer;
   import labyrinth.LabyrinthManager;
   
   public class TransmissionGate extends SimpleObject implements Disposeable, ITipedDisplay
   {
       
      
      private var _lightColor:ColorTransform;
      
      private var _normalColor:ColorTransform;
      
      protected var _tipData:Object;
      
      protected var _tipDirction:String;
      
      protected var _tipGapV:int;
      
      protected var _tipGapH:int;
      
      protected var _tipStyle:String;
      
      private var _timer:Timer;
      
      public function TransmissionGate(param1:int, param2:int, param3:String, param4:String)
      {
         super(param1,param2,param3,param4);
         _canCollided = true;
         setCollideRect(-50,-100,50,100);
         getCollideRect();
         _lightColor = new ColorTransform();
         _lightColor.redOffset = 0;
         _lightColor.greenOffset = 145;
         _lightColor.blueOffset = 239;
         _normalColor = new ColorTransform();
         mouseChildren = true;
         mouseEnabled = true;
         buttonMode = false;
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "4";
         tipGapV = 90;
         tipGapH = -20;
         if(LabyrinthManager.Instance.model.currentFloor == 30)
         {
            tipData = LanguageMgr.GetTranslation("game.objects.TransmissionGate.tips");
         }
         else
         {
            tipData = LanguageMgr.GetTranslation("game.objects.TransmissionGate.tipsII");
         }
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function __timerComplete(param1:TimerEvent) : void
      {
         GameInSocketOut.sendGameSkipNext(0);
      }
      
      override protected function creatMovie(param1:String) : void
      {
         var _loc2_:Class = ModuleLoader.getDefinition(m_model) as Class;
         if(_loc2_)
         {
            m_movie = new _loc2_();
            var _loc3_:* = 1.7;
            m_movie.scaleY = _loc3_;
            m_movie.scaleX = _loc3_;
            m_movie.addEventListener("mouseOver",__onOver);
            m_movie.addEventListener("mouseOut",__onOut);
            m_movie.addEventListener("click",__onClick);
            addChild(m_movie);
         }
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
      }
      
      protected function __onOut(param1:MouseEvent) : void
      {
         if(m_movie && m_movie.transform)
         {
            m_movie.transform.colorTransform = _normalColor;
         }
      }
      
      protected function __onOver(param1:MouseEvent) : void
      {
         if(m_movie && m_movie.transform)
         {
            m_movie.transform.colorTransform = _lightColor;
         }
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         if(m_movie)
         {
            m_movie.removeEventListener("mouseOver",__onOver);
            m_movie.removeEventListener("mouseOver",__onOut);
         }
         super.dispose();
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirction;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(_tipDirction == param1)
         {
            return;
         }
         _tipDirction = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(_tipGapV == param1)
         {
            return;
         }
         _tipGapV = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(_tipGapH == param1)
         {
            return;
         }
         _tipGapH = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         if(_tipStyle == param1)
         {
            return;
         }
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
