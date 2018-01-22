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
         var _loc1_:Array = ServerConfigManager.instance.pyramidTopMinMaxPoint;
         this.tipData = LanguageMgr.GetTranslation("ddt.pyramid.topBoxMovieTipsMsg",_loc1_[0],_loc1_[1]);
      }
      
      public function addTopBoxMovie(param1:Sprite) : void
      {
         _topBoxMovie = ComponentFactory.Instance.creat("assets.pyramid.topBox");
         _topBoxMovie.x = this.x;
         _topBoxMovie.y = this.y;
         _topBoxMovie.gotoAndStop(1);
         param1.addChild(_topBoxMovie);
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function topBoxMovieMode(param1:int = 0) : void
      {
         if(PyramidControl.instance.movieLock && param1 == 0)
         {
            return;
         }
         _state = param1;
         var _loc3_:Boolean = false;
         var _loc2_:MovieClip = _topBoxMovie["box"];
         switch(int(param1))
         {
            case 0:
               _loc2_.gotoAndStop(1);
               break;
            case 1:
               _loc3_ = true;
               _loc2_.gotoAndStop(2);
               break;
            case 2:
               _loc3_ = false;
               PyramidControl.instance.movieLock = true;
               _loc2_.addFrameScript(_loc2_.totalFrames - 1,toBoxMoviePlayStop);
               _loc2_.gotoAndPlay(3);
         }
         this.buttonMode = _loc3_;
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
