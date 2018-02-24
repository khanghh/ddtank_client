package com.pickgliss.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Rectangle;
   
   public class LayerManager
   {
      
      public static const STAGE_TOP_LAYER:int = 0;
      
      public static const STAGE_DYANMIC_LAYER:int = 1;
      
      public static const GAME_TOP_LAYER:int = 2;
      
      public static const GAME_DYNAMIC_LAYER:int = 3;
      
      public static const GAME_UI_LAYER:int = 4;
      
      public static const GAME_BASE_LAYER:int = 5;
      
      public static const GAME_BOTTOM_LAYER:int = 6;
      
      public static const STAGE_BOTTOM_LAYER:int = 7;
      
      public static const NONE_BLOCKGOUND:int = 0;
      
      public static const BLCAK_BLOCKGOUND:int = 1;
      
      public static const ALPHA_BLOCKGOUND:int = 2;
      
      private static var _instance:LayerManager;
       
      
      private var _stageTopLayer:SpriteLayer;
      
      private var _stageDynamicLayer:SpriteLayer;
      
      private var _stageBottomLayer:SpriteLayer;
      
      private var _gameTopLayer:SpriteLayer;
      
      private var _gameDynamicLayer:SpriteLayer;
      
      private var _gameUILayer:SpriteLayer;
      
      private var _gameBaseLayer:SpriteLayer;
      
      private var _gameBottomLayer:SpriteLayer;
      
      public function LayerManager(){super();}
      
      public static function get Instance() : LayerManager{return null;}
      
      public function setup(param1:Stage) : void{}
      
      public function getLayerByType(param1:int) : SpriteLayer{return null;}
      
      public function addToLayer(param1:DisplayObject, param2:int, param3:Boolean = false, param4:int = 0, param5:Boolean = true) : void{}
      
      public function clearnStageDynamic() : void{}
      
      public function clearnGameDynamic() : void{}
      
      public function clearAllGameDynamic() : void{}
      
      private function cleanSprite(param1:Sprite) : void{}
      
      public function get backGroundInParent() : Boolean{return false;}
   }
}
