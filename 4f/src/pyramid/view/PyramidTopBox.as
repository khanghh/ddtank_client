package pyramid.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import pyramid.PyramidControl;      public class PyramidTopBox extends Component   {                   private var _topBoxMovie:MovieClip;            private var _state:int;            public function PyramidTopBox() { super(); }
            public function addTopBoxMovie($parent:Sprite) : void { }
            public function get state() : int { return 0; }
            public function topBoxMovieMode(modeType:int = 0) : void { }
            private function toBoxMoviePlayStop() : void { }
            override public function dispose() : void { }
   }}