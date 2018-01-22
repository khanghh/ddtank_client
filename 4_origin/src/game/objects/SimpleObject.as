package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import gameCommon.view.smallMap.SmallLiving;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovie;
   
   public class SimpleObject extends PhysicalObj
   {
       
      
      protected var m_model:String;
      
      protected var m_action:String;
      
      protected var m_movie:MovieClip;
      
      protected var actionMapping:Dictionary;
      
      private var _smallMapView:SmallObject;
      
      private var _isBottom:Boolean;
      
      private var _shouldReCreate:Boolean = false;
      
      public function SimpleObject(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false)
      {
         super(param1,param2);
         actionMapping = new Dictionary();
         mouseChildren = false;
         mouseEnabled = false;
         scrollRect = null;
         m_model = param3;
         m_action = param4;
         _isBottom = param5;
         creatMovie(m_model);
         playAction(m_action);
         initSmallMapView();
      }
      
      override public function get layer() : int
      {
         if(_isBottom)
         {
            return 6;
         }
         return 5;
      }
      
      public function createMovieAfterLoadComplete() : void
      {
         creatMovie(m_model);
      }
      
      public function get shouldReCreate() : Boolean
      {
         return _shouldReCreate;
      }
      
      public function set shouldReCreate(param1:Boolean) : void
      {
         _shouldReCreate = param1;
      }
      
      protected function creatMovie(param1:String) : void
      {
         var _loc2_:* = null;
         if(ModuleLoader.hasDefinition(m_model))
         {
            shouldReCreate = false;
            _loc2_ = ModuleLoader.getDefinition(m_model) as Class;
            if(_loc2_)
            {
               m_movie = new _loc2_();
               addChild(m_movie);
            }
         }
         else
         {
            shouldReCreate = true;
         }
      }
      
      protected function initSmallMapView() : void
      {
         if(layerType == 0)
         {
            _smallMapView = new SmallLiving();
            _smallMapView.visible = false;
         }
      }
      
      override public function get smallView() : SmallObject
      {
         return _smallMapView;
      }
      
      public function playAction(param1:String) : void
      {
         if(actionMapping[param1])
         {
            param1 = actionMapping[param1];
         }
         if(m_movie is ActionMovie)
         {
            if(param1 != "")
            {
               m_movie.gotoAndPlay(param1);
            }
            return;
         }
         if(m_movie)
         {
            if(param1 is String)
            {
               var _loc4_:int = 0;
               var _loc3_:* = m_movie.currentLabels;
               for each(var _loc2_ in m_movie.currentLabels)
               {
                  if(_loc2_.name == param1)
                  {
                     m_movie.gotoAndPlay(param1);
                  }
               }
            }
         }
         if(param1 == "1" || param1 == "2")
         {
            if(m_movie)
            {
               m_movie.gotoAndPlay(param1);
            }
         }
         if(_smallMapView != null)
         {
            _smallMapView.visible = param1 == "2";
         }
      }
      
      override public function collidedByObject(param1:PhysicalObj) : void
      {
         playAction("pick");
      }
      
      override public function setActionMapping(param1:String, param2:String) : void
      {
         if(m_movie is ActionMovie)
         {
            (m_movie as ActionMovie).setActionMapping(param1,param2);
            return;
         }
         actionMapping[param1] = param2;
      }
      
      override public function dispose() : void
      {
         var _loc1_:SoundTransform = new SoundTransform();
         _loc1_.volume = 0;
         if(m_movie)
         {
            m_movie.stop();
            m_movie.soundTransform = _loc1_;
         }
         super.dispose();
         if(m_movie && m_movie.parent)
         {
            removeChild(m_movie);
         }
         m_movie = null;
         if(_smallMapView)
         {
            _smallMapView.dispose();
            _smallMapView = null;
         }
      }
      
      public function get movie() : MovieClip
      {
         return m_movie;
      }
   }
}
