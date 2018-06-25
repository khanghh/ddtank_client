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
      
      private var _realLayer:int;
      
      private var _shouldReCreate:Boolean = false;
      
      public function SimpleObject(id:int, type:int, model:String, action:String, layer:int = 5)
      {
         super(id,type);
         actionMapping = new Dictionary();
         mouseChildren = false;
         mouseEnabled = false;
         scrollRect = null;
         m_model = model;
         m_action = action;
         _realLayer = layer;
         creatMovie(m_model);
         playAction(m_action);
         initSmallMapView();
      }
      
      override public function get layer() : int
      {
         if(_realLayer == 6 || _realLayer == 7)
         {
            return _realLayer;
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
      
      public function set shouldReCreate(value:Boolean) : void
      {
         _shouldReCreate = value;
      }
      
      protected function creatMovie(model:String) : void
      {
         var moive_class:* = null;
         if(ModuleLoader.hasDefinition(m_model))
         {
            shouldReCreate = false;
            moive_class = ModuleLoader.getDefinition(m_model) as Class;
            if(moive_class)
            {
               m_movie = new moive_class();
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
      
      public function playAction(action:String) : void
      {
         if(actionMapping[action])
         {
            action = actionMapping[action];
         }
         if(m_movie is ActionMovie)
         {
            if(action != "")
            {
               m_movie.gotoAndPlay(action);
            }
            return;
         }
         if(m_movie)
         {
            if(action is String)
            {
               var _loc4_:int = 0;
               var _loc3_:* = m_movie.currentLabels;
               for each(var s in m_movie.currentLabels)
               {
                  if(s.name == action)
                  {
                     m_movie.gotoAndPlay(action);
                  }
               }
            }
         }
         if(action == "1" || action == "2")
         {
            if(m_movie)
            {
               m_movie.gotoAndPlay(action);
            }
         }
         if(_smallMapView != null)
         {
            _smallMapView.visible = action == "2";
         }
      }
      
      override public function collidedByObject(obj:PhysicalObj) : void
      {
         playAction("pick");
      }
      
      override public function setActionMapping(source:String, target:String) : void
      {
         if(m_movie is ActionMovie)
         {
            (m_movie as ActionMovie).setActionMapping(source,target);
            return;
         }
         actionMapping[source] = target;
      }
      
      override public function dispose() : void
      {
         var soundControl:SoundTransform = new SoundTransform();
         soundControl.volume = 0;
         if(m_movie)
         {
            m_movie.stop();
            m_movie.soundTransform = soundControl;
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
