package wonderfulActivity.views
{
   import RechargeRank.views.RechargeRankView;
   import activeEvents.data.ActiveEventsInfo;
   import carnivalActivity.view.CarnivalActivityView;
   import carnivalActivity.view.UsePropsView;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consumeRank.views.ConsumeRankView;
   import dayActivity.ActivityTypeData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.items.AccumulativePayView;
   import wonderfulActivity.items.DaySupplyAwardItem;
   import wonderfulActivity.items.FarmView;
   import wonderfulActivity.items.FighterRutrunView;
   import wonderfulActivity.items.HeroView;
   import wonderfulActivity.items.JoinIsPowerView;
   import wonderfulActivity.items.LimitActivityView;
   import wonderfulActivity.items.LuckStoneView;
   import wonderfulActivity.items.NewGameBenifitView;
   import wonderfulActivity.items.RechargeReturnView;
   import wonderfulActivity.items.StrengthDarenView;
   import wonderfulActivity.items.WasteRecycleItem;
   import wonderfulActivity.newActivity.AnnouncementAct.AnnouncementActView;
   import wonderfulActivity.newActivity.ExchangeAct.ExchangeActView;
   import wonderfulActivity.newActivity.GetRewardAct.GetRewardActView;
   import wonderfulActivity.newActivity.returnActivity.ReturnActivityView;
   
   public class WonderfulRightView extends Sprite implements Disposeable
   {
       
      
      private var _view:IRightView;
      
      private var _tittle:Bitmap;
      
      private var _currentInfo:ActiveEventsInfo;
      
      public function WonderfulRightView()
      {
         super();
      }
      
      public function setState(type:int, id:int) : void
      {
         if(!_view)
         {
            return;
         }
         _view.setState(type,id);
      }
      
      public function updateView(id:String) : void
      {
         var leftViewInfoDic:* = null;
         var data:* = null;
         dispose();
         if(WonderfulActivityManager.Instance.isExchangeAct)
         {
            leftViewInfoDic = WonderfulActivityManager.Instance.exchangeActLeftViewInfoDic;
         }
         else
         {
            leftViewInfoDic = WonderfulActivityManager.Instance.leftViewInfoDic;
         }
         var type:int = leftViewInfoDic[id].viewType;
         var _loc5_:* = type;
         if(3001 !== _loc5_)
         {
            if(4001 !== _loc5_)
            {
               if(2001 !== _loc5_)
               {
                  if(4 !== _loc5_)
                  {
                     if(1 !== _loc5_)
                     {
                        if(10 !== _loc5_)
                        {
                           if(9 !== _loc5_)
                           {
                              if(12 !== _loc5_)
                              {
                                 if(15 !== _loc5_)
                                 {
                                    if(14 !== _loc5_)
                                    {
                                       if(17 !== _loc5_)
                                       {
                                          if(18 !== _loc5_)
                                          {
                                             if(19 !== _loc5_)
                                             {
                                                if(40 !== _loc5_)
                                                {
                                                   if(20 !== _loc5_)
                                                   {
                                                      if(21 !== _loc5_)
                                                      {
                                                         if(22 !== _loc5_)
                                                         {
                                                            if(61 !== _loc5_)
                                                            {
                                                               if(23 !== _loc5_)
                                                               {
                                                                  if(24 !== _loc5_)
                                                                  {
                                                                     if(25 !== _loc5_)
                                                                     {
                                                                        if(41 !== _loc5_)
                                                                        {
                                                                           if(35 !== _loc5_)
                                                                           {
                                                                              if(26 !== _loc5_)
                                                                              {
                                                                                 if(27 !== _loc5_)
                                                                                 {
                                                                                    if(28 !== _loc5_)
                                                                                    {
                                                                                       if(29 !== _loc5_)
                                                                                       {
                                                                                          if(30 !== _loc5_)
                                                                                          {
                                                                                             if(31 !== _loc5_)
                                                                                             {
                                                                                                if(32 !== _loc5_)
                                                                                                {
                                                                                                   if(33 !== _loc5_)
                                                                                                   {
                                                                                                      if(34 !== _loc5_)
                                                                                                      {
                                                                                                         if(36 !== _loc5_)
                                                                                                         {
                                                                                                            if(37 !== _loc5_)
                                                                                                            {
                                                                                                               if(42 !== _loc5_)
                                                                                                               {
                                                                                                                  if(43 !== _loc5_)
                                                                                                                  {
                                                                                                                     if(44 !== _loc5_)
                                                                                                                     {
                                                                                                                        if(45 !== _loc5_)
                                                                                                                        {
                                                                                                                           if(46 !== _loc5_)
                                                                                                                           {
                                                                                                                              if(47 !== _loc5_)
                                                                                                                              {
                                                                                                                                 if(48 !== _loc5_)
                                                                                                                                 {
                                                                                                                                    if(49 !== _loc5_)
                                                                                                                                    {
                                                                                                                                       if(38 !== _loc5_)
                                                                                                                                       {
                                                                                                                                          if(39 !== _loc5_)
                                                                                                                                          {
                                                                                                                                             if(50 !== _loc5_)
                                                                                                                                             {
                                                                                                                                                if(51 !== _loc5_)
                                                                                                                                                {
                                                                                                                                                   if(52 !== _loc5_)
                                                                                                                                                   {
                                                                                                                                                      if(_view)
                                                                                                                                                      {
                                                                                                                                                         _view.dispose();
                                                                                                                                                         _view = null;
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      _view = new CarnivalActivityView(39);
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   _view = new DaySupplyAwardItem(id);
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                _view = new WasteRecycleItem();
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             _view = new CarnivalActivityView(18);
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _view = new CarnivalActivityView(17);
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _view = new UsePropsView(28,0);
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _view = new CarnivalActivityView(26);
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _view = new CarnivalActivityView(25);
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _view = new CarnivalActivityView(24);
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _view = new CarnivalActivityView(27);
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _view = new CarnivalActivityView(23);
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _view = new CarnivalActivityView(22);
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _view = new CarnivalActivityView(21);
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _view = new CarnivalActivityView(16);
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _view = new CarnivalActivityView(15,11);
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _view = new CarnivalActivityView(15,9);
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _view = new CarnivalActivityView(15,8);
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _view = new CarnivalActivityView(15,7);
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _view = new CarnivalActivityView(15,6);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _view = new CarnivalActivityView(15,5);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _view = new CarnivalActivityView(15,4);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _view = new CarnivalActivityView(15,3);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _view = new CarnivalActivityView(15,2);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _view = new CarnivalActivityView(15,1);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _view = new CarnivalActivityView(15,10);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _view = new CarnivalActivityView(20,0,id);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _view = new CarnivalActivityView(14,1);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _view = new CarnivalActivityView(14,0);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  _view = new ConsumeRankView();
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _view = new RechargeRankView();
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _view = new GetRewardActView(id);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _view = new AnnouncementActView(id);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _view = new ExchangeActView(id);
                                                   }
                                                }
                                                else
                                                {
                                                   _view = new ReturnActivityView(3,id);
                                                }
                                             }
                                             else
                                             {
                                                _view = new ReturnActivityView(1,id);
                                             }
                                          }
                                          else
                                          {
                                             _view = new ReturnActivityView(0,id);
                                          }
                                       }
                                       else
                                       {
                                          _view = new ReturnActivityView(2,id);
                                       }
                                    }
                                    else
                                    {
                                       _view = new JoinIsPowerView();
                                    }
                                 }
                                 else
                                 {
                                    _view = new StrengthDarenView();
                                 }
                              }
                              else
                              {
                                 _view = new AccumulativePayView();
                              }
                           }
                           else
                           {
                              _view = new NewGameBenifitView();
                           }
                        }
                        else
                        {
                           _view = new HeroView();
                        }
                     }
                     else
                     {
                        _view = new LuckStoneView();
                     }
                  }
                  else
                  {
                     _view = new FarmView();
                  }
               }
               else
               {
                  data = WonderfulActivityManager.Instance.activityFighterList[0];
                  _view = new FighterRutrunView(data);
               }
            }
            else
            {
               data = WonderfulActivityManager.Instance.activityExpList[0];
               _view = new RechargeReturnView(2,data);
            }
         }
         else
         {
            data = WonderfulActivityManager.Instance.activityRechargeList[0];
            _view = new RechargeReturnView(1,data);
         }
         if(type >= 10000 && type <= 11000)
         {
            _view = new LimitActivityView(type);
         }
         if(_view)
         {
            _view.init();
            addChild(_view.content());
            WonderfulActivityManager.Instance.currentView = _view;
         }
      }
      
      public function dispose() : void
      {
         if(_view)
         {
            _view.dispose();
         }
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}
