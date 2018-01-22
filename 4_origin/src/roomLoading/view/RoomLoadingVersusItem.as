package roomLoading.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import room.RoomManager;
   
   public class RoomLoadingVersusItem extends Sprite implements Disposeable
   {
       
      
      private var _gameType:Bitmap;
      
      private var _gameTypeBg:Bitmap;
      
      private var _versusMc:DisplayObject;
      
      private var _gameMode:int;
      
      private var _glowFilter:GlowFilter;
      
      private var _survival:Bitmap;
      
      public function RoomLoadingVersusItem(param1:int)
      {
         super();
         _gameMode = param1;
         init();
      }
      
      private function init() : void
      {
         _glowFilter = new GlowFilter();
         _versusMc = ComponentFactory.Instance.creat("asset.roomloading.versus");
         PositionUtils.setPos(_versusMc,"asset.roomLoading.VersusAnimationPos");
         addChild(_versusMc);
         if(RoomManager.Instance.current.type == 121)
         {
            _survival = ComponentFactory.Instance.creat("asset.roomloading.survival");
            addChild(_survival);
            TweenMax.from(_survival,1,{
               "alpha":0,
               "delay":1
            });
         }
         else
         {
            _gameTypeBg = ComponentFactory.Instance.creatBitmap("asset.roomloading.gameTypeBg");
            addChild(_gameTypeBg);
            PositionUtils.setPos(_gameTypeBg,"asset.roomLoading.GameTypeBgPos");
            createGameModeTxt();
            if(_gameType)
            {
               TweenMax.from(_gameType,1,{
                  "alpha":0,
                  "delay":1
               });
            }
            TweenMax.from(_gameTypeBg,1,{
               "alpha":0,
               "delay":1
            });
         }
      }
      
      private function addEffect() : void
      {
         TweenMax.to(_glowFilter,0.45,{
            "startAt":{
               "blurX":0,
               "blurY":0,
               "color":16763904,
               "strength":0
            },
            "blurX":5,
            "blurY":5,
            "color":16737792,
            "strength":0.6,
            "yoyo":true,
            "repeat":-1,
            "ease":Sine.easeOut,
            "onUpdate":updateFilter
         });
      }
      
      private function updateFilter() : void
      {
         if(_gameType)
         {
            _gameType.filters = [_glowFilter];
         }
      }
      
      private function createGameModeTxt() : void
      {
         if(_gameMode == 7)
         {
            if(RoomManager.Instance.current.type == 51)
            {
               _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_41");
            }
         }
         if(!_gameType)
         {
            var _loc1_:* = _gameMode;
            if(0 !== _loc1_)
            {
               if(4 !== _loc1_)
               {
                  if(9 !== _loc1_)
                  {
                     if(11 !== _loc1_)
                     {
                        if(1 !== _loc1_)
                        {
                           if(2 !== _loc1_)
                           {
                              if(7 !== _loc1_)
                              {
                                 if(10 !== _loc1_)
                                 {
                                    if(30 !== _loc1_)
                                    {
                                       if(48 !== _loc1_)
                                       {
                                          if(8 !== _loc1_)
                                          {
                                             if(12 !== _loc1_)
                                             {
                                                if(13 !== _loc1_)
                                                {
                                                   if(15 !== _loc1_)
                                                   {
                                                      if(16 !== _loc1_)
                                                      {
                                                         if(17 !== _loc1_)
                                                         {
                                                            if(21 !== _loc1_)
                                                            {
                                                               if(120 !== _loc1_)
                                                               {
                                                                  if(24 !== _loc1_)
                                                                  {
                                                                     if(23 !== _loc1_)
                                                                     {
                                                                        if(25 !== _loc1_)
                                                                        {
                                                                           if(26 !== _loc1_)
                                                                           {
                                                                              if(40 !== _loc1_)
                                                                              {
                                                                                 if(28 !== _loc1_)
                                                                                 {
                                                                                    if(29 !== _loc1_)
                                                                                    {
                                                                                       if(31 !== _loc1_)
                                                                                       {
                                                                                          if(42 !== _loc1_)
                                                                                          {
                                                                                             if(68 !== _loc1_)
                                                                                             {
                                                                                                if(43 !== _loc1_)
                                                                                                {
                                                                                                   if(47 !== _loc1_)
                                                                                                   {
                                                                                                      _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_0");
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _gameType = null;
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_43");
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_44");
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_42");
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_43");
                                                                                       }
                                                                                    }
                                                                                 }
                                                                                 _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_3");
                                                                              }
                                                                              else
                                                                              {
                                                                                 _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_40");
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_26");
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_7");
                                                                        }
                                                                     }
                                                                  }
                                                                  _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_22");
                                                               }
                                                               else if(RoomManager.Instance.current.type == 1)
                                                               {
                                                                  _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_2");
                                                               }
                                                               else
                                                               {
                                                                  _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.TrialGameModel_47");
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_21");
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_17");
                                                         }
                                                      }
                                                   }
                                                   _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_14");
                                                }
                                             }
                                             _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_12");
                                          }
                                          else
                                          {
                                             _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_8");
                                          }
                                       }
                                    }
                                    addr56:
                                    _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_7");
                                 }
                                 addr55:
                                 §§goto(addr56);
                              }
                              §§goto(addr55);
                           }
                           else
                           {
                              _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_2");
                           }
                        }
                        else
                        {
                           _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_1");
                        }
                     }
                  }
                  addr26:
                  _gameType = ComponentFactory.Instance.creatBitmap("asset.roomLoading.GameMode_0");
               }
               addr25:
               §§goto(addr26);
            }
            §§goto(addr25);
         }
         if(_gameType)
         {
            addChild(_gameType);
         }
      }
      
      public function dispose() : void
      {
         if(_gameType)
         {
            TweenMax.killTweensOf(_gameType);
         }
         if(_glowFilter)
         {
            TweenMax.killTweensOf(_glowFilter);
         }
         if(_gameType)
         {
            _gameType.filters = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _gameType = null;
         _gameTypeBg = null;
         _survival = null;
         _glowFilter = null;
         _versusMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
