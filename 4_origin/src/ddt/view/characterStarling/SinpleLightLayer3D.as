package ddt.view.characterStarling
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.ILayer;
   import flash.display.DisplayObject;
   import starling.display.Sprite;
   
   public class SinpleLightLayer3D extends Sprite implements ILayer
   {
       
      
      private var _light:BoneMovieStarling;
      
      private var _type:int;
      
      private var _callBack:Function;
      
      private var _nimbus:int;
      
      private var _styleName:String;
      
      private var _isComplete:Boolean;
      
      public function SinpleLightLayer3D(nimbus:int, showType:int = 0)
      {
         super();
         _nimbus = nimbus;
         _type = showType;
      }
      
      public function load(callBack:Function) : void
      {
         _callBack = callBack;
         initLoader();
      }
      
      protected function initLoader() : void
      {
         if(_nimbus != 0)
         {
            _styleName = "game.crazyTank.view.light.SinpleLightAsset_" + getId();
            BonesLoaderManager.instance.addEventListener("complete",__onLoaderComplete);
            BonesLoaderManager.instance.startLoader(_styleName);
         }
      }
      
      private function __onLoaderComplete(e:BonesLoaderEvent) : void
      {
         if(_styleName == e.vo.styleName)
         {
            BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
            _light = BoneMovieFactory.instance.creatBoneMovie(_styleName);
            _isComplete = true;
            if(_callBack != null && _light != null)
            {
               _callBack(this);
            }
         }
      }
      
      public function getshowTypeString() : String
      {
         if(_type == 0)
         {
            return "show";
         }
         return "game";
      }
      
      private function getId() : String
      {
         if(_nimbus == 0)
         {
            return "00";
         }
         var nimbus:String = _nimbus.toString();
         nimbus = nimbus.substr(nimbus.length - 2,nimbus.length);
         nimbus = Number(nimbus).toString();
         return nimbus;
      }
      
      public function getContent3D() : BoneMovieStarling
      {
         return _light as BoneMovieStarling;
      }
      
      override public function dispose() : void
      {
         BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
         if(_light && _light.parent)
         {
            _light.parent.removeChild(_light);
         }
         _light = null;
         _callBack = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
      }
      
      public function get info() : ItemTemplateInfo
      {
         return null;
      }
      
      public function getContent() : DisplayObject
      {
         return null;
      }
      
      public function set currentEdit(n:int) : void
      {
      }
      
      public function get currentEdit() : int
      {
         return 0;
      }
      
      public function setColor(color:*) : Boolean
      {
         return false;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
   }
}
