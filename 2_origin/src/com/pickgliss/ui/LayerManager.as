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
      
      public function LayerManager()
      {
         super();
      }
      
      public static function get Instance() : LayerManager
      {
         if(_instance == null)
         {
            _instance = new LayerManager();
         }
         return _instance;
      }
      
      public function setup(stage:Stage) : void
      {
         _stageTopLayer = new SpriteLayer();
         _stageDynamicLayer = new SpriteLayer();
         _stageBottomLayer = new SpriteLayer(true);
         _gameTopLayer = new SpriteLayer();
         _gameDynamicLayer = new SpriteLayer();
         _gameUILayer = new SpriteLayer();
         _gameBaseLayer = new SpriteLayer();
         _gameBottomLayer = new SpriteLayer();
         stage.addChild(_stageBottomLayer);
         stage.addChild(_stageDynamicLayer);
         stage.addChild(_stageTopLayer);
         _gameDynamicLayer.autoClickTotop = true;
         _stageBottomLayer.addChild(_gameBottomLayer);
         _stageBottomLayer.addChild(_gameBaseLayer);
         _stageBottomLayer.addChild(_gameUILayer);
         _stageBottomLayer.addChild(_gameDynamicLayer);
         _stageBottomLayer.addChild(_gameTopLayer);
      }
      
      public function getLayerByType(type:int) : SpriteLayer
      {
         switch(int(type))
         {
            case 0:
               return _stageTopLayer;
            case 1:
               return _stageDynamicLayer;
            case 2:
               return _gameTopLayer;
            case 3:
               return _gameDynamicLayer;
            case 4:
               return _gameUILayer;
            case 5:
               return _gameBaseLayer;
            case 6:
               return _gameBottomLayer;
            case 7:
               return _stageBottomLayer;
         }
      }
      
      public function addToLayer(source:DisplayObject, type:int, center:Boolean = false, blockBackgound:int = 0, focusTop:Boolean = true) : void
      {
         var visibleSize:* = null;
         var container:SpriteLayer = getLayerByType(type);
         if(center)
         {
            if(source is Component)
            {
               source.x = (StageReferance.stageWidth - source.width) / 2;
               source.y = (StageReferance.stageHeight - source.height) / 2;
            }
            else
            {
               visibleSize = DisplayUtils.getVisibleSize(source);
               source.x = (StageReferance.stageWidth - visibleSize.width) / 2;
               source.y = (StageReferance.stageHeight - visibleSize.height) / 2;
            }
         }
         container.addTolayer(source,blockBackgound,focusTop);
      }
      
      public function clearnStageDynamic() : void
      {
         cleanSprite(_stageDynamicLayer);
      }
      
      public function clearnGameDynamic() : void
      {
         cleanSprite(_gameDynamicLayer);
      }
      
      public function clearAllGameDynamic() : void
      {
         cleanSprite(_stageBottomLayer);
         cleanSprite(_stageDynamicLayer);
         cleanSprite(_stageTopLayer);
      }
      
      private function cleanSprite(target:Sprite) : void
      {
         var child:* = null;
         while(target.numChildren > 0)
         {
            child = target.getChildAt(0);
            ObjectUtils.disposeObject(child);
         }
      }
      
      public function get backGroundInParent() : Boolean
      {
         if(!_stageTopLayer.backGroundInParent && !_stageDynamicLayer.backGroundInParent && !_stageBottomLayer.backGroundInParent && !_gameTopLayer.backGroundInParent && !_gameDynamicLayer.backGroundInParent && !_gameUILayer.backGroundInParent && !_gameBaseLayer.backGroundInParent && !_gameBottomLayer.backGroundInParent)
         {
            return false;
         }
         return true;
      }
   }
}
