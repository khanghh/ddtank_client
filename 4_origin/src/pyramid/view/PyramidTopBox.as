package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import pyramid.PyramidControl;
   
   public class PyramidTopBox extends Component
   {
       
      
      private var _topBoxMovie:MovieClip;
      
      private var _state:int;
      
      public function PyramidTopBox()
      {
         super();
         this.graphics.beginFill(16777215,0);
         this.graphics.drawRect(0,0,100,100);
         this.graphics.endFill();
         this.tipStyle = "ddt.view.tips.OneLineTip";
         this.tipDirctions = "7,3";
         this.tipGapH = 100;
         this.tipGapV = 50;
         var pyramidTopMinMaxPoint:Array = ServerConfigManager.instance.pyramidTopMinMaxPoint;
         this.tipData = LanguageMgr.GetTranslation("ddt.pyramid.topBoxMovieTipsMsg",pyramidTopMinMaxPoint[0],pyramidTopMinMaxPoint[1]);
      }
      
      public function addTopBoxMovie($parent:Sprite) : void
      {
         _topBoxMovie = ComponentFactory.Instance.creat("assets.pyramid.topBox");
         _topBoxMovie.x = this.x;
         _topBoxMovie.y = this.y;
         _topBoxMovie.gotoAndStop(1);
         $parent.addChild(_topBoxMovie);
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function topBoxMovieMode(modeType:int = 0) : void
      {
         if(PyramidControl.instance.movieLock && modeType == 0)
         {
            return;
         }
         _state = modeType;
         var bool:Boolean = false;
         var boxMovie:MovieClip = _topBoxMovie["box"];
         switch(int(modeType))
         {
            case 0:
               boxMovie.gotoAndStop(1);
               break;
            case 1:
               bool = true;
               boxMovie.gotoAndStop(2);
               break;
            case 2:
               bool = false;
               PyramidControl.instance.movieLock = true;
               boxMovie.addFrameScript(boxMovie.totalFrames - 1,toBoxMoviePlayStop);
               boxMovie.gotoAndPlay(3);
         }
         this.buttonMode = bool;
      }
      
      private function toBoxMoviePlayStop() : void
      {
         PyramidControl.instance.movieLock = false;
         if(_topBoxMovie)
         {
            topBoxMovieMode(0);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.graphics.clear();
         ObjectUtils.disposeObject(_topBoxMovie);
         _topBoxMovie = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
