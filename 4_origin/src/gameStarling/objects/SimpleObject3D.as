package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.utils.Dictionary;
   import gameCommon.view.smallMap.SmallLiving;
   import phy.object.SmallObject;
   import starlingPhy.object.PhysicalObj3D;
   
   public class SimpleObject3D extends PhysicalObj3D
   {
       
      
      protected var m_model:String;
      
      protected var m_action:String;
      
      protected var m_movie:BoneMovieStarling;
      
      protected var actionMapping:Dictionary;
      
      protected var _smallMapView:SmallLiving;
      
      private var _isBottom:Boolean;
      
      private var _shouldReCreate:Boolean = false;
      
      public function SimpleObject3D(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false)
      {
         super(param1,param2);
         actionMapping = new Dictionary();
         touchable = false;
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
      }
      
      protected function creatMovie(param1:String) : void
      {
         m_movie = BoneMovieFactory.instance.creatBoneMovie(m_model);
         addChild(m_movie);
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
         if(_smallMapView != null)
         {
            _smallMapView.visible = param1 == "2";
         }
      }
      
      override public function collidedByObject(param1:PhysicalObj3D) : void
      {
         playAction("pick");
      }
      
      override public function setActionMapping(param1:String, param2:String) : void
      {
         actionMapping[param1] = param2;
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(m_movie);
         ObjectUtils.disposeObject(_smallMapView);
         m_movie = null;
         _smallMapView = null;
         super.dispose();
      }
      
      public function get movie() : BoneMovieStarling
      {
         return m_movie;
      }
   }
}
