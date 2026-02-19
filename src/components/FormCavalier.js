import React, { useState } from 'react';
import { supabase, APP_KEY } from '../supabaseClient';

export default function FormCavalier({ fetchData }) {
  const [prenom, setPrenom] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    await supabase.from('cavaliers').insert([{ prenom, app_key: APP_KEY }]);
    setPrenom('');
    fetchData();
  }

  return (
    <form onSubmit={handleSubmit}>
      <h3>Ajouter Cavalier</h3>
      <input type="text" value={prenom} onChange={e=>setPrenom(e.target.value)} placeholder="Prénom"/>
      <button type="submit">Ajouter</button>
    </form>
  )
}