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
   
   public class BaseLightLayer3D extends Sprite implements ILayer
   {
       
      
      private var _light:BoneMovieStarling;
      
      private var _type:int;
      
      private var _callBack:Function;
      
      private var _nimbus:int;
      
      private var _styleName:String;
      
      private var _isComplete:Boolean;
      
      public function BaseLightLayer3D(param1:int, param2:int = 0){super();}
      
      public function load(param1:Function) : void{}
      
      protected function initLoader() : void{}
      
      private function __onLoaderComplete(param1:BonesLoaderEvent) : void{}
      
      public function getshowTypeString() : String{return null;}
      
      private function getId() : String{return null;}
      
      public function getContent3D() : BoneMovieStarling{return null;}
      
      override public function dispose() : void{}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function getContent() : DisplayObject{return null;}
      
      public function set currentEdit(param1:int) : void{}
      
      public function get currentEdit() : int{return 0;}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function get isComplete() : Boolean{return false;}
   }
}
