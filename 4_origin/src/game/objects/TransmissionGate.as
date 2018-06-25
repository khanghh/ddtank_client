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
      
      public function TransmissionGate(id:int, type:int, model:String, action:String)
      {
         super(id,type,model,action);
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
      
      protected function __timerComplete(event:TimerEvent) : void
      {
         GameInSocketOut.sendGameSkipNext(0);
      }
      
      override protected function creatMovie(model:String) : void
      {
         var moive_class:Class = ModuleLoader.getDefinition(m_model) as Class;
         if(moive_class)
         {
            m_movie = new moive_class();
            var _loc3_:* = 1.7;
            m_movie.scaleY = _loc3_;
            m_movie.scaleX = _loc3_;
            m_movie.addEventListener("mouseOver",__onOver);
            m_movie.addEventListener("mouseOut",__onOut);
            m_movie.addEventListener("click",__onClick);
            addChild(m_movie);
         }
      }
      
      protected function __onClick(event:MouseEvent) : void
      {
      }
      
      protected function __onOut(event:MouseEvent) : void
      {
         if(m_movie && m_movie.transform)
         {
            m_movie.transform.colorTransform = _normalColor;
         }
      }
      
      protected function __onOver(event:MouseEvent) : void
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
      
      public function set tipData(value:Object) : void
      {
         if(_tipData == value)
         {
            return;
         }
         _tipData = value;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirction;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirction == value)
         {
            return;
         }
         _tipDirction = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         if(_tipGapV == value)
         {
            return;
         }
         _tipGapV = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         if(_tipGapH == value)
         {
            return;
         }
         _tipGapH = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         if(_tipStyle == value)
         {
            return;
         }
         _tipStyle = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
