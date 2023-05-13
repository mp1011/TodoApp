import React from 'react';
import Login from './login';

function TopNav() {
  
    return (
        <nav className="navbar navbar-expand-lg navbar-dark bg-primary w-100 fixed-top">
          <div className="container-fluid">
            <div className="collapse navbar-collapse">
              <ul className="navbar-nav ms-auto mb-2 mb-lg-0">
                <li className="nav-item">
                  <Login />
                </li>
              </ul>
            </div>
          </div>
        </nav>
      );
}

export default TopNav;
